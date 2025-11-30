package com.shop.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shop.entity.Product;
import com.shop.service.ProductService; // Assuming you have this service interface
import com.shop.utils.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/backend/product")
@Tag(name = "后台-商品管理")
public class AdminProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/list")
    @Operation(summary = "商品列表")
    public Result<Page<Product>> list(@RequestParam(defaultValue = "1") Integer page,
                                      @RequestParam(defaultValue = "10") Integer size,
                                      @RequestParam(required = false) String name) {
        Page<Product> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        if (name != null && !name.isEmpty()) {
            wrapper.like(Product::getName, name);
        }
        wrapper.orderByDesc(Product::getCreateTime);
        return Result.success(productService.page(pageParam, wrapper));
    }

    @PostMapping("/add")
    @Operation(summary = "添加商品")
    public Result<String> add(@RequestBody Product product) {
        productService.save(product);
        return Result.success("添加成功");
    }

    @PutMapping("/update")
    @Operation(summary = "更新商品")
    public Result<String> update(@RequestBody Product product) {
        productService.updateById(product);
        return Result.success("更新成功");
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除商品")
    public Result<String> delete(@PathVariable Long id) {
        productService.removeById(id);
        return Result.success("删除成功");
    }
}
