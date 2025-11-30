-- 预置数据脚本

USE `shop_db`;

-- 1. 清理旧数据
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `product`;
TRUNCATE TABLE `product_category`;
TRUNCATE TABLE `user`;
TRUNCATE TABLE `order_master`;
TRUNCATE TABLE `order_detail`;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. 插入分类
INSERT INTO `product_category` (id, name, sort) VALUES 
(1, '智能手机', 1),
(2, '笔记本电脑', 2),
(3, '平板电脑', 3),
(4, '智能穿戴', 4),
(5, '影音娱乐', 5),
(6, '数码配件', 6);

-- 3. 插入商品 (50条示例)
INSERT INTO `product` (category_id, name, description, price, image, status) VALUES
(1, 'iPhone 15 Pro', '钛金属设计，A17 Pro 芯片', 7999.00, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Samsung Galaxy S24', 'AI 手机，超视觉夜拍', 5999.00, 'https://images.unsplash.com/photo-1610945265078-3858a0828671?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Xiaomi 14', '徕卡光学镜头，骁龙8 Gen3', 3999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Google Pixel 8', 'Google AI，纯净安卓', 4999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(1, 'OnePlus 12', '十年超越之作', 4299.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(2, 'MacBook Pro 14', 'M3 Max 芯片，深空黑', 14999.00, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca4?auto=format&fit=crop&w=500&q=60', 1),
(2, 'Dell XPS 13', '微边框设计，轻薄便携', 9999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(2, 'ThinkPad X1 Carbon', '商务旗舰，碳纤维机身', 11999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(2, 'HP Spectre x360', '翻转触控，OLED 屏幕', 10999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(2, 'ASUS ROG Zephyrus', '游戏本，RTX 4090', 18999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(3, 'iPad Pro 12.9', 'M2 芯片，XDR 显示屏', 8499.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(3, 'iPad Air 5', 'M1 芯片，多彩设计', 4799.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(3, 'Samsung Galaxy Tab S9', 'AMOLED 屏幕，S Pen', 5499.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(4, 'Apple Watch Ultra 2', '极限运动，双频 GPS', 6499.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(4, 'Apple Watch Series 9', 'S9 SiP，双指互点', 2999.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(5, 'AirPods Pro 2', '主动降噪，自适应通透', 1899.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(5, 'Sony WH-1000XM5', '头戴式降噪耳机', 2499.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(5, 'Bose QC45', '消噪耳机，舒适佩戴', 1999.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(6, 'Anker 65W Charger', '氮化镓充电器', 199.00, 'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?auto=format&fit=crop&w=500&q=60', 1),
(6, 'Logitech MX Master 3S', '无线鼠标，静音滚轮', 699.00, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Huawei Mate 60 Pro', '卫星通话，昆仑玻璃', 6999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Honor Magic 6', '鹰眼相机，青海湖电池', 4399.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Vivo X100', '蔡司影像，蓝晶芯片', 3999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Oppo Find X7', '哈苏大师影像', 3999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(2, 'Microsoft Surface Laptop', '触控屏，Alcantara 材质', 8999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(2, 'Razer Blade 15', '灵刃游戏本', 15999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(2, 'LG Gram 16', '超轻薄，长续航', 9999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(3, 'Microsoft Surface Pro 9', '二合一平板电脑', 7999.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(3, 'Lenovo Tab P12', '大屏平板，学习办公', 2999.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(4, 'Huawei Watch GT 4', '时尚设计，科学运动', 1488.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(4, 'Garmin Fenix 7', '户外运动手表', 5999.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(5, 'Marshall Major IV', '摇滚复古，无线蓝牙', 1299.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(5, 'JBL Flip 6', '便携蓝牙音箱', 899.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?auto=format&fit=crop&w=500&q=60', 1),
(6, 'Keychron K2', '机械键盘，Mac 适配', 499.00, 'https://images.unsplash.com/photo-1587829741301-dc798b91a603?auto=format&fit=crop&w=500&q=60', 1),
(6, 'SanDisk SSD 1TB', '移动固态硬盘', 699.00, 'https://images.unsplash.com/photo-1597872252165-4828a1561780?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Redmi K70', '性价比之王', 2499.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(1, 'Realme GT 5', '极速秒充', 2999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(2, 'Acer Swift Go', '轻薄本，OLED', 5999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(2, 'MacBook Air 15', '大屏轻薄，M2', 10499.00, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca4?auto=format&fit=crop&w=500&q=60', 1),
(3, 'iPad mini 6', '小屏旗舰', 3999.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(4, 'Xiaomi Band 8', '智能手环', 249.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(5, 'Sony WF-1000XM5', '降噪豆', 1999.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(6, 'Logitech G502', '游戏鼠标', 299.00, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?auto=format&fit=crop&w=500&q=60', 1),
(6, 'Samsung T7', '移动硬盘', 599.00, 'https://images.unsplash.com/photo-1597872252165-4828a1561780?auto=format&fit=crop&w=500&q=60', 1),
(1, 'iPhone 14', '超值入手', 5399.00, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?auto=format&fit=crop&w=500&q=60', 1),
(1, 'iPhone 13', '经典款', 4399.00, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?auto=format&fit=crop&w=500&q=60', 1),
(2, 'Lenovo Legion R9000P', '拯救者游戏本', 8999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(3, 'Huawei MatePad Pro', '鸿蒙平板', 4299.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(4, 'Amazfit GTR 4', '长续航手表', 1099.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(5, 'Beats Studio Pro', '头戴式耳机', 2499.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1);

-- 4. 插入用户
INSERT INTO `user` (username, password, email, phone, address) VALUES
('test_user', 'e10adc3949ba59abbe56e057f20f883e', 'test@example.com', '13800138000', '北京市朝阳区'),
('vip_user', 'e10adc3949ba59abbe56e057f20f883e', 'vip@example.com', '13900139000', '上海市浦东新区');

-- 5. 插入订单
INSERT INTO `order_master` (order_no, user_id, total_amount, status, create_time) VALUES
('ORD20231125001', 1, 7999.00, 3, DATE_SUB(NOW(), INTERVAL 5 DAY)),
('ORD20231125002', 1, 299.00, 2, DATE_SUB(NOW(), INTERVAL 2 DAY)),
('ORD20231125003', 2, 14999.00, 1, NOW());

INSERT INTO `order_detail` (order_id, product_id, product_name, product_price, quantity) VALUES
(1, 1, 'iPhone 15 Pro', 7999.00, 1),
(2, 43, 'Logitech G502', 299.00, 1),
(3, 6, 'MacBook Pro 14', 14999.00, 1);

-- 6. 插入销售统计
INSERT INTO `sales_report` (date, total_sales, total_orders) VALUES
(DATE_SUB(CURDATE(), INTERVAL 1 DAY), 15000.00, 5),
(DATE_SUB(CURDATE(), INTERVAL 2 DAY), 23000.00, 8),
(DATE_SUB(CURDATE(), INTERVAL 3 DAY), 12000.00, 4),
(DATE_SUB(CURDATE(), INTERVAL 4 DAY), 35000.00, 12),
(DATE_SUB(CURDATE(), INTERVAL 5 DAY), 18000.00, 6);
