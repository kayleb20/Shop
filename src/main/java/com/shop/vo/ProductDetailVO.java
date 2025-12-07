package com.shop.vo;

import com.shop.entity.Product;
import com.shop.entity.ProductSku;
import lombok.Data;

import java.util.List;

@Data
public class ProductDetailVO {
    private Product product;
    private List<ProductSku> skus;
}
