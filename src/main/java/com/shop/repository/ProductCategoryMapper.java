package com.shop.repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shop.entity.ProductCategory;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductCategoryMapper extends BaseMapper<ProductCategory> {
}
