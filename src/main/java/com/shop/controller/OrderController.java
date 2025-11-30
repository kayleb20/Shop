package com.shop.controller;

import com.shop.entity.OrderMaster;
import com.shop.utils.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/order")
@Tag(name = "订单模块")
public class OrderController {

    @PostMapping("/create")
    @Operation(summary = "创建订单")
    public Result<String> create() {
        return Result.success("订单创建成功");
    }

    @GetMapping("/list")
    @Operation(summary = "我的订单列表")
    public Result<List<OrderMaster>> list() {
        return Result.success();
    }

    @GetMapping("/{orderNo}")
    @Operation(summary = "订单详情")
    public Result<OrderMaster> detail(@PathVariable String orderNo) {
        return Result.success();
    }

    @PostMapping("/pay/{orderNo}")
    @Operation(summary = "模拟支付")
    public Result<String> pay(@PathVariable String orderNo) {
        return Result.success("支付成功");
    }
    
    @PostMapping("/send/{orderNo}")
    @Operation(summary = "发货(管理员)")
    public Result<String> send(@PathVariable String orderNo) {
        return Result.success("发货成功");
    }
}
