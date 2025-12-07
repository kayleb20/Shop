package com.shop.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("order_detail")
public class OrderDetail {
    @TableId(type = IdType.AUTO)
    private Long id;

    private Long orderId;
    private Long productId;
    private Long skuId; // Added SKU ID
    private String productName;
    private String specs; // Added Specs snapshot
    private BigDecimal productPrice;
    private Integer quantity;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
}
