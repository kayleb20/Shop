package com.shop.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shop.entity.OrderMaster;
import com.shop.utils.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 后台订单管理接口
 */
@RestController
@RequestMapping("/backend/order")
@Tag(name = "后台-订单管理")
public class AdminOrderController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.shop.service.OrderService orderService;

    /**
     * 获取所有订单列表
     *
     * @param page 页码
     * @param size 每页大小
     * @return 订单列表
     */
    @GetMapping("/list")
    @Operation(summary = "所有订单列表")
    public Result<Page<OrderMaster>> list(@RequestParam(defaultValue = "1") Integer page,
                                          @RequestParam(defaultValue = "10") Integer size) {
        Page<OrderMaster> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(OrderMaster::getCreateTime);
        Page<OrderMaster> result = orderService.page(pageParam, wrapper);
        return Result.success(result);
    }

    /**
     * 获取订单详情
     *
     * @param orderNo 订单编号
     * @return 订单详情
     */
    @GetMapping("/{orderNo}")
    @Operation(summary = "订单详情")
    public Result<OrderMaster> detail(@PathVariable String orderNo) {
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(OrderMaster::getOrderNo, orderNo);
        OrderMaster orderMaster = orderService.getOne(wrapper);
        return Result.success(orderMaster);
    }

    /**
     * 订单发货
     *
     * @param orderNo 订单编号
     * @return 操作结果
     */
    @PostMapping("/send/{orderNo}")
    @Operation(summary = "发货")
    public Result<String> send(@PathVariable String orderNo) {
        orderService.send(orderNo);
        return Result.success("发货成功");
    }
}
