package com.shop.repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shop.entity.ProductSku;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductSkuMapper extends BaseMapper<ProductSku> {
}
