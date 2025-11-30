package com.shop.controller;

import com.shop.entity.Product;
import com.shop.utils.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/product")
@Tag(name = "商品模块")
public class ProductController {

    @GetMapping("/list")
    @Operation(summary = "获取商品列表")
    public Result<List<Product>> list(@RequestParam(defaultValue = "1") Integer page, 
                                    @RequestParam(defaultValue = "10") Integer size,
                                    @RequestParam(required = false) String keyword) {
        return Result.success();
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取商品详情")
    public Result<Product> detail(@PathVariable Long id) {
        return Result.success();
    }

    @PostMapping("/add")
    @Operation(summary = "添加商品(管理员)")
    public Result<String> add(@RequestBody Product product) {
        return Result.success("添加成功");
    }

    @PutMapping("/update")
    @Operation(summary = "更新商品(管理员)")
    public Result<String> update(@RequestBody Product product) {
        return Result.success("更新成功");
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除商品(管理员)")
    public Result<String> delete(@PathVariable Long id) {
        return Result.success("删除成功");
    }
}
