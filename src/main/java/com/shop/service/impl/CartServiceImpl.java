package com.shop.service.impl;

import com.shop.dto.CartAddDTO;
import com.shop.entity.Product;
import com.shop.entity.ProductSku;
import com.shop.repository.ProductSkuMapper;
import com.shop.service.CartService;
import com.shop.service.ProductService;
import com.shop.vo.CartItemVO;
import com.shop.vo.CartVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductSkuMapper productSkuMapper;

    private static final String CART_PREFIX = "cart:";
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void add(String username, CartAddDTO cartAddDTO) {
        String key = CART_PREFIX + username;
        Long skuId = cartAddDTO.getSkuId();
        Integer quantity = cartAddDTO.getQuantity();

        // Validate SKU
        ProductSku sku = productSkuMapper.selectById(skuId);
        if (sku == null) {
            throw new RuntimeException("商品规格不存在");
        }
        if (sku.getStock() < quantity) {
            throw new RuntimeException("库存不足");
        }

        // Use skuId as the hash key
        String hashKey = skuId.toString();

        // Check if item exists
        Object existingQty = redisTemplate.opsForHash().get(key, hashKey);
        if (existingQty != null) {
            int currentQty = Integer.parseInt(existingQty.toString());
            redisTemplate.opsForHash().put(key, hashKey, String.valueOf(currentQty + quantity));
        } else {
            redisTemplate.opsForHash().put(key, hashKey, String.valueOf(quantity));
        }
    }

    @Override
    public CartVO list(String username) {
        String key = CART_PREFIX + username;
        Map<Object, Object> entries = redisTemplate.opsForHash().entries(key);

        CartVO cartVO = new CartVO();
        List<CartItemVO> items = new ArrayList<>();
        BigDecimal totalPrice = BigDecimal.ZERO;
        int totalQuantity = 0;

        if (entries.isEmpty()) {
            cartVO.setItems(items);
            cartVO.setTotalPrice(totalPrice);
            cartVO.setTotalQuantity(totalQuantity);
            return cartVO;
        }

        for (Map.Entry<Object, Object> entry : entries.entrySet()) {
            Long skuId = Long.valueOf(entry.getKey().toString());
            Integer quantity = Integer.valueOf(entry.getValue().toString());

            ProductSku sku = productSkuMapper.selectById(skuId);
            if (sku != null) {
                Product product = productService.getById(sku.getProductId());
                if (product != null) {
                    CartItemVO item = new CartItemVO();
                    item.setProductId(product.getId());
                    item.setSkuId(sku.getId());
                    item.setProductName(product.getName());
                    // Use SKU image if available, otherwise Product main image
                    item.setProductIcon(sku.getImage() != null ? sku.getImage() : product.getMainImage());
                    item.setPrice(sku.getPrice());
                    item.setQuantity(quantity);
                    
                    // Convert specs map to string
                    try {
                        item.setSpecs(objectMapper.writeValueAsString(sku.getSpecs()));
                    } catch (Exception e) {
                        item.setSpecs("{}");
                    }

                    BigDecimal subTotal = sku.getPrice().multiply(new BigDecimal(quantity));
                    item.setSubTotal(subTotal);

                    items.add(item);
                    totalPrice = totalPrice.add(subTotal);
                    totalQuantity += quantity;
                }
            } else {
                // SKU might be deleted, remove from cart
                redisTemplate.opsForHash().delete(key, skuId.toString());
            }
        }

        cartVO.setItems(items);
        cartVO.setTotalPrice(totalPrice);
        cartVO.setTotalQuantity(totalQuantity);
        return cartVO;
    }

    @Override
    public void update(String username, Long skuId, Integer quantity) {
        String key = CART_PREFIX + username;
        if (quantity > 0) {
            redisTemplate.opsForHash().put(key, skuId.toString(), quantity.toString());
        } else {
            delete(username, skuId);
        }
    }

    @Override
    public void delete(String username, Long skuId) {
        String key = CART_PREFIX + username;
        redisTemplate.opsForHash().delete(key, skuId.toString());
    }
}
