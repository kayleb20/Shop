package com.shop.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shop.dto.OrderCreateDTO;
import com.shop.entity.OrderMaster;
import com.shop.vo.OrderVO;
import java.math.BigDecimal;
import java.util.List;

public interface OrderService extends IService<OrderMaster> {
    String create(String username, OrderCreateDTO orderCreateDTO);
    List<OrderVO> list(String username);
    OrderVO detail(String username, String orderNo);
    void pay(String username, String orderNo);
    void send(String orderNo); // Admin only
    
    // Stats
    BigDecimal getTotalSales();
    long countPendingOrders();
    BigDecimal getSalesByDateRange(java.time.LocalDateTime start, java.time.LocalDateTime end);
    long countOrdersByDateRange(java.time.LocalDateTime start, java.time.LocalDateTime end);
    long countPendingOrdersByDateRange(java.time.LocalDateTime start, java.time.LocalDateTime end);
    List<OrderMaster> findRecentOrders(int limit);
    java.util.Map<String, BigDecimal> getDailySales(java.time.LocalDateTime start, java.time.LocalDateTime end);
}
