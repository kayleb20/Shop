package com.shop.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.shop.dto.OrderCreateDTO;
import com.shop.entity.OrderDetail;
import com.shop.entity.OrderMaster;
import com.shop.entity.Product;
import com.shop.entity.User;
import com.shop.repository.OrderDetailMapper;
import com.shop.repository.OrderMasterMapper;
import com.shop.entity.ProductSku;
import com.shop.repository.ProductSkuMapper;
import com.shop.repository.UserMapper;
import com.shop.service.CartService;
import com.shop.service.OrderService;
import com.shop.service.ProductService;
import com.shop.vo.CartItemVO;
import com.shop.vo.CartVO;
import com.shop.vo.OrderItemVO;
import com.shop.vo.OrderVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl extends com.baomidou.mybatisplus.extension.service.impl.ServiceImpl<OrderMasterMapper, OrderMaster> implements OrderService {

    @Autowired
    private CartService cartService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductSkuMapper productSkuMapper;

    @Autowired
    private OrderMasterMapper orderMasterMapper;

    @Autowired
    private OrderDetailMapper orderDetailMapper;

    @Autowired
    private com.shop.service.EmailService emailService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private com.shop.service.ReceiverService receiverService;

    @Override
    @Transactional
    public String create(String username, OrderCreateDTO orderCreateDTO) {
        // 1. Get User ID
        LambdaQueryWrapper<User> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.eq(User::getUsername, username);
        User user = userMapper.selectOne(userWrapper);
        if (user == null) {
            throw new RuntimeException("User not found");
        }

        // 2. Get Cart Items
        CartVO cartVO = cartService.list(username);
        if (cartVO.getItems() == null || cartVO.getItems().isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        // 3. Create Order Master
        OrderMaster orderMaster = new OrderMaster();
        // Gene Method: Time + Random + UserID suffix
        String timeStr = java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now());
        String randomStr = String.format("%04d", (int) (Math.random() * 10000));
        String userIdStr = String.valueOf(user.getId());
        String userSuffix = userIdStr.length() >= 4 ? userIdStr.substring(userIdStr.length() - 4) : String.format("%04d", user.getId());
        orderMaster.setOrderNo(timeStr + randomStr + userSuffix);
        
        orderMaster.setUserId(user.getId());
        orderMaster.setTotalAmount(cartVO.getTotalPrice());
        orderMaster.setStatus(0); // New Order
        orderMaster.setPaymentMethod(orderCreateDTO.getPaymentMethod());

        // Fill Receiver Info
        if (orderCreateDTO.getReceiverId() != null) {
            com.shop.entity.Receiver receiver = receiverService.getById(orderCreateDTO.getReceiverId());
            if (receiver != null) {
                orderMaster.setReceiverName(receiver.getName());
                orderMaster.setReceiverPhone(receiver.getPhone());
                orderMaster.setReceiverAddress(receiver.getAddress());
            }
        } else {
            orderMaster.setReceiverName(orderCreateDTO.getReceiverName());
            orderMaster.setReceiverPhone(orderCreateDTO.getReceiverPhone());
            orderMaster.setReceiverAddress(orderCreateDTO.getReceiverAddress());
        }

        orderMasterMapper.insert(orderMaster);

        // 4. Create Order Details & Deduct Stock
        for (CartItemVO item : cartVO.getItems()) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderId(orderMaster.getId());
            orderDetail.setProductId(item.getProductId());
            orderDetail.setSkuId(item.getSkuId());
            orderDetail.setProductName(item.getProductName());
            orderDetail.setSpecs(item.getSpecs());
            orderDetail.setProductPrice(item.getPrice());
            orderDetail.setQuantity(item.getQuantity());
            orderDetailMapper.insert(orderDetail);

            // Deduct Stock from SKU
            ProductSku sku = productSkuMapper.selectById(item.getSkuId());
            if (sku == null) {
                throw new RuntimeException("Product SKU not found: " + item.getSkuId());
            }
            if (sku.getStock() < item.getQuantity()) {
                throw new RuntimeException("Insufficient stock for SKU: " + item.getSkuId());
            }
            sku.setStock(sku.getStock() - item.getQuantity());
            productSkuMapper.updateById(sku);
        }

        // 5. Clear Cart
        for (CartItemVO item : cartVO.getItems()) {
            cartService.delete(username, item.getSkuId());
        }

        return orderMaster.getOrderNo();
    }

    @Override
    public List<OrderVO> list(String username) {
        LambdaQueryWrapper<User> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.eq(User::getUsername, username);
        User user = userMapper.selectOne(userWrapper);

        LambdaQueryWrapper<OrderMaster> orderWrapper = new LambdaQueryWrapper<>();
        orderWrapper.eq(OrderMaster::getUserId, user.getId());
        orderWrapper.orderByDesc(OrderMaster::getCreateTime);
        List<OrderMaster> orderMasters = orderMasterMapper.selectList(orderWrapper);

        return orderMasters.stream().map(this::convertToVO).collect(Collectors.toList());
    }

    @Override
    public OrderVO detail(String username, String orderNo) {
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(OrderMaster::getOrderNo, orderNo);
        OrderMaster orderMaster = orderMasterMapper.selectOne(wrapper);
        
        if (orderMaster == null) {
            throw new RuntimeException("Order not found");
        }
        // Security check: ensure order belongs to user
        // ...

        return convertToVO(orderMaster);
    }

    @Override
    public void pay(String username, String orderNo) {
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(OrderMaster::getOrderNo, orderNo);
        OrderMaster orderMaster = orderMasterMapper.selectOne(wrapper);
        
        if (orderMaster != null && orderMaster.getStatus() == 0) {
            orderMaster.setStatus(1); // Paid
            orderMaster.setPaymentTime(LocalDateTime.now());
            orderMasterMapper.updateById(orderMaster);

            // Send email
            User user = userMapper.selectById(orderMaster.getUserId());
            if (user != null && user.getEmail() != null) {
                String subject = "订单支付成功通知 - " + orderNo;
                String content = String.format(
                    "尊敬的用户 %s，您好：\n\n" +
                    "您的订单已支付成功！\n" +
                    "--------------------------------\n" +
                    "订单编号：%s\n" +
                    "支付金额：￥%s\n" +
                    "支付时间：%s\n" +
                    "收货人：%s\n" +
                    "收货地址：%s\n" +
                    "联系电话：%s\n" +
                    "--------------------------------\n" +
                    "我们会尽快为您安排发货，请耐心等待。\n" +
                    "感谢您的光临！",
                    user.getUsername(),
                    orderNo,
                    orderMaster.getTotalAmount(),
                    orderMaster.getPaymentTime(),
                    orderMaster.getReceiverName(),
                    orderMaster.getReceiverAddress(),
                    orderMaster.getReceiverPhone()
                );
                emailService.sendSimpleMessage(user.getEmail(), subject, content);
            }
        }
    }

    @Override
    public void send(String orderNo) {
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(OrderMaster::getOrderNo, orderNo);
        OrderMaster orderMaster = orderMasterMapper.selectOne(wrapper);
        
        if (orderMaster != null && orderMaster.getStatus() == 1) {
            orderMaster.setStatus(2); // Shipped
            orderMaster.setDeliveryTime(LocalDateTime.now());
            orderMasterMapper.updateById(orderMaster);

            // Send email
            User user = userMapper.selectById(orderMaster.getUserId());
            if (user != null && user.getEmail() != null) {
                String subject = "订单发货通知 - " + orderNo;
                String content = String.format(
                    "尊敬的用户 %s，您好：\n\n" +
                    "您的订单已经发货啦！\n" +
                    "--------------------------------\n" +
                    "订单编号：%s\n" +
                    "发货时间：%s\n" +
                    "收货人：%s\n" +
                    "收货地址：%s\n" +
                    "联系电话：%s\n" +
                    "--------------------------------\n" +
                    "请保持电话畅通，以便快递员联系您。\n" +
                    "收到商品后，如有任何问题请及时联系我们。\n" +
                    "祝您生活愉快！",
                    user.getUsername(),
                    orderNo,
                    orderMaster.getDeliveryTime(),
                    orderMaster.getReceiverName(),
                    orderMaster.getReceiverAddress(),
                    orderMaster.getReceiverPhone()
                );
                emailService.sendSimpleMessage(user.getEmail(), subject, content);
            }
        }
    }

    @Override
    public BigDecimal getTotalSales() {
        // Sum total_amount where status >= 1 (Paid)
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.ge(OrderMaster::getStatus, 1);
        List<OrderMaster> orders = orderMasterMapper.selectList(wrapper);
        return orders.stream()
                .map(OrderMaster::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public long countPendingOrders() {
        // Count where status = 0 (Unpaid) or 1 (Paid, not shipped)
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(OrderMaster::getStatus, 0, 1);
        return orderMasterMapper.selectCount(wrapper);
    }

    @Override
    public BigDecimal getSalesByDateRange(LocalDateTime start, LocalDateTime end) {
        List<Integer> statuses = List.of(1, 2, 3);
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(OrderMaster::getStatus, statuses)
               .ge(OrderMaster::getCreateTime, start)
               .lt(OrderMaster::getCreateTime, end);
        List<OrderMaster> orders = this.list(wrapper);
        return orders.stream()
                .map(OrderMaster::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public long countOrdersByDateRange(LocalDateTime start, LocalDateTime end) {
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.ge(OrderMaster::getCreateTime, start)
               .lt(OrderMaster::getCreateTime, end);
        return this.count(wrapper);
    }

    @Override
    public long countPendingOrdersByDateRange(LocalDateTime start, LocalDateTime end) {
        // Status: 0-Unpaid, 1-Paid (Pending Shipment)
        List<Integer> statuses = List.of(0, 1);
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(OrderMaster::getStatus, statuses)
               .ge(OrderMaster::getCreateTime, start)
               .lt(OrderMaster::getCreateTime, end);
        return this.count(wrapper);
    }

    @Override
    public List<OrderMaster> findRecentOrders(int limit) {
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(OrderMaster::getCreateTime)
               .last("LIMIT " + limit);
        return this.list(wrapper);
    }

    @Override
    public java.util.Map<String, BigDecimal> getDailySales(LocalDateTime start, LocalDateTime end) {
        List<Integer> statuses = List.of(1, 2, 3); // Paid, Shipped, Completed
        LambdaQueryWrapper<OrderMaster> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(OrderMaster::getStatus, statuses)
               .ge(OrderMaster::getCreateTime, start)
               .lt(OrderMaster::getCreateTime, end);
        List<OrderMaster> orders = this.list(wrapper);
        
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        
        return orders.stream()
                .collect(Collectors.groupingBy(
                        order -> order.getCreateTime().format(formatter),
                        Collectors.reducing(BigDecimal.ZERO, OrderMaster::getTotalAmount, BigDecimal::add)
                ));
    }

    private OrderVO convertToVO(OrderMaster orderMaster) {
        OrderVO orderVO = new OrderVO();
        BeanUtils.copyProperties(orderMaster, orderVO);

        LambdaQueryWrapper<OrderDetail> detailWrapper = new LambdaQueryWrapper<>();
        detailWrapper.eq(OrderDetail::getOrderId, orderMaster.getId());
        List<OrderDetail> details = orderDetailMapper.selectList(detailWrapper);

        List<OrderItemVO> itemVOs = details.stream().map(detail -> {
            OrderItemVO itemVO = new OrderItemVO();
            BeanUtils.copyProperties(detail, itemVO);
            itemVO.setPrice(detail.getProductPrice()); // Map productPrice to price
            itemVO.setTotal(detail.getProductPrice().multiply(new BigDecimal(detail.getQuantity())));
            // Need to fetch product icon if needed
            return itemVO;
        }).collect(Collectors.toList());

        orderVO.setItems(itemVOs);
        return orderVO;
    }
}
