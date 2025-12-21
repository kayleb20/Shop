package com.shop.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shop.entity.ProductCategory;
import com.shop.repository.ProductCategoryMapper;
import com.shop.service.ProductCategoryService;
import org.springframework.stereotype.Service;

@Service
public class ProductCategoryServiceImpl extends ServiceImpl<ProductCategoryMapper, ProductCategory> implements ProductCategoryService {
}
