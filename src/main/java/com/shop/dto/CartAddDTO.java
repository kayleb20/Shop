package com.shop.dto;

import lombok.Data;

@Data
public class CartAddDTO {
    private Long productId;
    private Long skuId;
    private Integer quantity;
}
