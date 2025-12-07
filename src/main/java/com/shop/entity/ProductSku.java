package com.shop.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

@Data
@TableName(value = "product_sku", autoResultMap = true)
public class ProductSku {
    @TableId(type = IdType.AUTO)
    private Long id;

    private Long productId;

    /**
     * 规格参数，例如：{"color": "黑色", "size": "XL"}
     * 数据库中存储为 JSON
     */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private Map<String, String> specs;

    private BigDecimal price;
    private Integer stock;
    private String image;
    private String skuCode;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @TableLogic
    private Integer deleted;
}
