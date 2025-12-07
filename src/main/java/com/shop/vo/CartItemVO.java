package com.shop.vo;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class CartItemVO {
    private Long productId;
    private Long skuId;
    private String productName;
    private String specs; // JSON string or formatted string
    private String productIcon;
    private BigDecimal price;
    private Integer quantity;
    private BigDecimal subTotal; // price * quantity
}
