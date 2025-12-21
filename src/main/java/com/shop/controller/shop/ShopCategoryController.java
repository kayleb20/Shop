package com.shop.controller.shop;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.shop.entity.ProductCategory;
import com.shop.service.ProductCategoryService;
import com.shop.utils.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/category")
@Tag(name = "前台-分类接口")
public class ShopCategoryController {

    @Autowired
    private ProductCategoryService categoryService;

    @GetMapping("/list")
    @Operation(summary = "获取所有分类")
    public Result<List<ProductCategory>> list() {
        LambdaQueryWrapper<ProductCategory> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(ProductCategory::getSort);
        return Result.success(categoryService.list(wrapper));
    }
}
