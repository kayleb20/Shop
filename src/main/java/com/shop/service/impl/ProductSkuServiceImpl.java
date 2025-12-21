package com.shop.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shop.entity.ProductSku;
import com.shop.repository.ProductSkuMapper;
import com.shop.service.ProductSkuService;
import org.springframework.stereotype.Service;

@Service
public class ProductSkuServiceImpl extends ServiceImpl<ProductSkuMapper, ProductSku> implements ProductSkuService {
}
