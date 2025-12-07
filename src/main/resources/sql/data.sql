-- 预置数据脚本

USE `shop_db`;

-- 1. 清理旧数据
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `product`;
TRUNCATE TABLE `product_sku`;
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

-- 3. 插入商品 (SPU)
INSERT INTO `product` (id, category_id, name, description, min_price, main_image, status) VALUES
(1, 1, 'iPhone 15 Pro', '钛金属设计，A17 Pro 芯片', 7999.00, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?auto=format&fit=crop&w=500&q=60', 1),
(2, 1, 'Samsung Galaxy S24', 'AI 手机，超视觉夜拍', 5999.00, 'https://images.unsplash.com/photo-1610945265078-3858a0828671?auto=format&fit=crop&w=500&q=60', 1),
(3, 1, 'Xiaomi 14', '徕卡光学镜头，骁龙8 Gen3', 3999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(4, 1, 'Google Pixel 8', 'Google AI，纯净安卓', 4999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(5, 1, 'OnePlus 12', '十年超越之作', 4299.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(6, 2, 'MacBook Pro 14', 'M3 Max 芯片，深空黑', 14999.00, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca4?auto=format&fit=crop&w=500&q=60', 1),
(7, 2, 'Dell XPS 13', '微边框设计，轻薄便携', 9999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(8, 2, 'ThinkPad X1 Carbon', '商务旗舰，碳纤维机身', 11999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(9, 2, 'HP Spectre x360', '翻转触控，OLED 屏幕', 10999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(10, 2, 'ASUS ROG Zephyrus', '游戏本，RTX 4090', 18999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(11, 3, 'iPad Pro 12.9', 'M2 芯片，XDR 显示屏', 8499.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(12, 3, 'iPad Air 5', 'M1 芯片，多彩设计', 4799.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(13, 3, 'Samsung Galaxy Tab S9', 'AMOLED 屏幕，S Pen', 5499.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(14, 4, 'Apple Watch Ultra 2', '极限运动，双频 GPS', 6499.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(15, 4, 'Apple Watch Series 9', 'S9 SiP，双指互点', 2999.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(16, 5, 'AirPods Pro 2', '主动降噪，自适应通透', 1899.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(17, 5, 'Sony WH-1000XM5', '头戴式降噪耳机', 2499.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(18, 5, 'Bose QC45', '消噪耳机，舒适佩戴', 1999.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(19, 6, 'Anker 65W Charger', '氮化镓充电器', 199.00, 'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?auto=format&fit=crop&w=500&q=60', 1),
(20, 6, 'Logitech MX Master 3S', '无线鼠标，静音滚轮', 699.00, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?auto=format&fit=crop&w=500&q=60', 1),
(21, 1, 'Huawei Mate 60 Pro', '卫星通话，昆仑玻璃', 6999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(22, 1, 'Honor Magic 6', '鹰眼相机，青海湖电池', 4399.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(23, 1, 'Vivo X100', '蔡司影像，蓝晶芯片', 3999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(24, 1, 'Oppo Find X7', '哈苏大师影像', 3999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(25, 2, 'Microsoft Surface Laptop', '触控屏，Alcantara 材质', 8999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(26, 2, 'Razer Blade 15', '灵刃游戏本', 15999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(27, 2, 'LG Gram 16', '超轻薄，长续航', 9999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(28, 3, 'Microsoft Surface Pro 9', '二合一平板电脑', 7999.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(29, 3, 'Lenovo Tab P12', '大屏平板，学习办公', 2999.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(30, 4, 'Huawei Watch GT 4', '时尚设计，科学运动', 1488.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(31, 4, 'Garmin Fenix 7', '户外运动手表', 5999.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(32, 5, 'Marshall Major IV', '摇滚复古，无线蓝牙', 1299.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(33, 5, 'JBL Flip 6', '便携蓝牙音箱', 899.00, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?auto=format&fit=crop&w=500&q=60', 1),
(34, 6, 'Keychron K2', '机械键盘，Mac 适配', 499.00, 'https://images.unsplash.com/photo-1587829741301-dc798b91a603?auto=format&fit=crop&w=500&q=60', 1),
(35, 6, 'SanDisk SSD 1TB', '移动固态硬盘', 699.00, 'https://images.unsplash.com/photo-1597872252165-4828a1561780?auto=format&fit=crop&w=500&q=60', 1),
(36, 1, 'Redmi K70', '性价比之王', 2499.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(37, 1, 'Realme GT 5', '极速秒充', 2999.00, 'https://images.unsplash.com/photo-1598327105666-5b89351aff23?auto=format&fit=crop&w=500&q=60', 1),
(38, 2, 'Acer Swift Go', '轻薄本，OLED', 5999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(39, 2, 'MacBook Air 15', '大屏轻薄，M2', 10499.00, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca4?auto=format&fit=crop&w=500&q=60', 1),
(40, 3, 'iPad mini 6', '小屏旗舰', 3999.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(41, 4, 'Xiaomi Band 8', '智能手环', 249.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(42, 5, 'Sony WF-1000XM5', '降噪豆', 1999.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1),
(43, 6, 'Logitech G502', '游戏鼠标', 299.00, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?auto=format&fit=crop&w=500&q=60', 1),
(44, 6, 'Samsung T7', '移动硬盘', 599.00, 'https://images.unsplash.com/photo-1597872252165-4828a1561780?auto=format&fit=crop&w=500&q=60', 1),
(45, 1, 'iPhone 14', '超值入手', 5399.00, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?auto=format&fit=crop&w=500&q=60', 1),
(46, 1, 'iPhone 13', '经典款', 4399.00, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?auto=format&fit=crop&w=500&q=60', 1),
(47, 2, 'Lenovo Legion R9000P', '拯救者游戏本', 8999.00, 'https://images.unsplash.com/photo-1593642632823-8f78536788c6?auto=format&fit=crop&w=500&q=60', 1),
(48, 3, 'Huawei MatePad Pro', '鸿蒙平板', 4299.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=500&q=60', 1),
(49, 4, 'Amazfit GTR 4', '长续航手表', 1099.00, 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?auto=format&fit=crop&w=500&q=60', 1),
(50, 5, 'Beats Studio Pro', '头戴式耳机', 2499.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', 1);

-- 4. 插入商品规格 (SKU)
-- 为每个商品生成一个默认 SKU
INSERT INTO `product_sku` (id, product_id, specs, price, stock, image, sku_code) VALUES
(1, 1, '{"color": "原色钛金属", "storage": "256GB"}', 7999.00, 100, NULL, 'IP15P-TI-256'),
(2, 2, '{"color": "钛灰", "storage": "256GB"}', 5999.00, 100, NULL, 'S24-GR-256'),
(3, 3, '{"color": "黑色", "storage": "256GB"}', 3999.00, 100, NULL, 'MI14-BK-256'),
(4, 4, '{"color": "黑曜石", "storage": "128GB"}', 4999.00, 100, NULL, 'PXL8-BK-128'),
(5, 5, '{"color": "留白", "storage": "256GB"}', 4299.00, 100, NULL, 'OP12-WH-256'),
(6, 6, '{"color": "深空黑", "chip": "M3 Max"}', 14999.00, 50, NULL, 'MBP14-BK-M3'),
(7, 7, '{"color": "银色", "cpu": "i7"}', 9999.00, 50, NULL, 'XPS13-SV-I7'),
(8, 8, '{"color": "黑色", "cpu": "i7"}', 11999.00, 50, NULL, 'X1C-BK-I7'),
(9, 9, '{"color": "皇室蓝", "cpu": "i7"}', 10999.00, 50, NULL, 'HP360-BL-I7'),
(10, 10, '{"color": "黑色", "gpu": "RTX4090"}', 18999.00, 20, NULL, 'ROG-BK-4090'),
(11, 11, '{"color": "深空灰", "storage": "128GB"}', 8499.00, 100, NULL, 'IPAD-PRO-128'),
(12, 12, '{"color": "蓝色", "storage": "64GB"}', 4799.00, 100, NULL, 'IPAD-AIR-64'),
(13, 13, '{"color": "灰色", "storage": "128GB"}', 5499.00, 100, NULL, 'TAB-S9-128'),
(14, 14, '{"color": "钛金属", "band": "高山回环"}', 6499.00, 100, NULL, 'AW-ULTRA-2'),
(15, 15, '{"color": "午夜色", "size": "45mm"}', 2999.00, 100, NULL, 'AW-S9-45'),
(16, 16, '{"color": "白色"}', 1899.00, 200, NULL, 'APP2-WH'),
(17, 17, '{"color": "黑色"}', 2499.00, 100, NULL, 'XM5-BK'),
(18, 18, '{"color": "黑色"}', 1999.00, 100, NULL, 'QC45-BK'),
(19, 19, '{"color": "黑色"}', 199.00, 500, NULL, 'ANKER-65W'),
(20, 20, '{"color": "石墨灰"}', 699.00, 200, NULL, 'MX3S-GR'),
(21, 21, '{"color": "雅川青", "storage": "512GB"}', 6999.00, 100, NULL, 'MATE60-GR-512'),
(22, 22, '{"color": "海湖青", "storage": "256GB"}', 4399.00, 100, NULL, 'MAGIC6-GR-256'),
(23, 23, '{"color": "星迹蓝", "storage": "256GB"}', 3999.00, 100, NULL, 'X100-BL-256'),
(24, 24, '{"color": "大漠银月", "storage": "256GB"}', 3999.00, 100, NULL, 'X7-SV-256'),
(25, 25, '{"color": "亮铂金", "cpu": "i5"}', 8999.00, 50, NULL, 'SL-SV-I5'),
(26, 26, '{"color": "黑色", "gpu": "RTX4070"}', 15999.00, 30, NULL, 'RAZER-15-4070'),
(27, 27, '{"color": "白色", "cpu": "i5"}', 9999.00, 50, NULL, 'GRAM16-WH-I5'),
(28, 28, '{"color": "亮铂金", "cpu": "i5"}', 7999.00, 50, NULL, 'SP9-SV-I5'),
(29, 29, '{"color": "灰色", "storage": "128GB"}', 2999.00, 100, NULL, 'TAB-P12-128'),
(30, 30, '{"color": "黑色", "size": "46mm"}', 1488.00, 100, NULL, 'GT4-BK-46'),
(31, 31, '{"color": "黑色", "size": "47mm"}', 5999.00, 50, NULL, 'FENIX7-BK'),
(32, 32, '{"color": "黑色"}', 1299.00, 100, NULL, 'MAJOR4-BK'),
(33, 33, '{"color": "黑色"}', 899.00, 100, NULL, 'FLIP6-BK'),
(34, 34, '{"switch": "红轴", "light": "RGB"}', 499.00, 100, NULL, 'K2-RED-RGB'),
(35, 35, '{"color": "黑色", "capacity": "1TB"}', 699.00, 200, NULL, 'SSD-1TB'),
(36, 36, '{"color": "墨羽", "storage": "256GB"}', 2499.00, 100, NULL, 'K70-BK-256'),
(37, 37, '{"color": "流银幻镜", "storage": "256GB"}', 2999.00, 100, NULL, 'GT5-SV-256'),
(38, 38, '{"color": "银色", "cpu": "i5"}', 5999.00, 50, NULL, 'SWIFT-SV-I5'),
(39, 39, '{"color": "午夜色", "storage": "256GB"}', 10499.00, 50, NULL, 'MBA15-BK-256'),
(40, 40, '{"color": "紫色", "storage": "64GB"}', 3999.00, 100, NULL, 'MINI6-PL-64'),
(41, 41, '{"color": "黑色"}', 249.00, 500, NULL, 'BAND8-BK'),
(42, 42, '{"color": "黑色"}', 1999.00, 100, NULL, 'XM5-EAR-BK'),
(43, 43, '{"color": "黑色"}', 299.00, 200, NULL, 'G502-BK'),
(44, 44, '{"color": "钛灰", "capacity": "1TB"}', 599.00, 200, NULL, 'T7-GR-1TB'),
(45, 45, '{"color": "蓝色", "storage": "128GB"}', 5399.00, 100, NULL, 'IP14-BL-128'),
(46, 46, '{"color": "粉色", "storage": "128GB"}', 4399.00, 100, NULL, 'IP13-PK-128'),
(47, 47, '{"color": "灰色", "gpu": "RTX4060"}', 8999.00, 50, NULL, 'R9000P-GR-4060'),
(48, 48, '{"color": "曜金黑", "storage": "128GB"}', 4299.00, 100, NULL, 'MATEPAD-BK-128'),
(49, 49, '{"color": "黑色"}', 1099.00, 100, NULL, 'GTR4-BK'),
(50, 50, '{"color": "黑色"}', 2499.00, 100, NULL, 'STUDIO-BK');

-- 更多 SKU 数据
INSERT INTO `product_sku` (id, product_id, specs, price, stock, image, sku_code) VALUES
(51, 1, '{"color": "蓝色钛金属", "storage": "256GB"}', 7999.00, 50, NULL, 'IP15P-BL-256'),
(52, 1, '{"color": "白色钛金属", "storage": "512GB"}', 9999.00, 30, NULL, 'IP15P-WH-512'),
(53, 1, '{"color": "黑色钛金属", "storage": "1TB"}', 11999.00, 20, NULL, 'IP15P-BK-1TB'),
(54, 2, '{"color": "钛黑", "storage": "512GB"}', 6999.00, 50, NULL, 'S24-BK-512'),
(55, 2, '{"color": "钛紫", "storage": "256GB"}', 5999.00, 80, NULL, 'S24-PL-256'),
(56, 6, '{"color": "银色", "chip": "M3 Pro"}', 12999.00, 40, NULL, 'MBP14-SV-M3PRO'),
(57, 6, '{"color": "深空黑", "chip": "M3 Pro"}', 12999.00, 40, NULL, 'MBP14-BK-M3PRO'),
(58, 16, '{"color": "定制黑"}', 2199.00, 10, NULL, 'APP2-BK-CUSTOM'),
(59, 34, '{"switch": "青轴", "light": "白光"}', 459.00, 80, NULL, 'K2-BLUE-WHITE'),
(60, 34, '{"switch": "茶轴", "light": "RGB"}', 499.00, 60, NULL, 'K2-BROWN-RGB');

-- 5. 插入用户
INSERT INTO `user` (username, password, email, phone, address) VALUES
('test_user', 'e10adc3949ba59abbe56e057f20f883e', 'test@example.com', '13800138000', '北京市朝阳区'),
('vip_user', 'e10adc3949ba59abbe56e057f20f883e', 'vip@example.com', '13900139000', '上海市浦东新区');

-- 6. 插入订单
INSERT INTO `order_master` (order_no, user_id, total_amount, status, create_time) VALUES
('ORD20231125001', 1, 7999.00, 3, DATE_SUB(NOW(), INTERVAL 5 DAY)),
('ORD20231125002', 1, 299.00, 2, DATE_SUB(NOW(), INTERVAL 2 DAY)),
('ORD20231125003', 2, 14999.00, 1, NOW());

INSERT INTO `order_detail` (order_id, product_id, sku_id, product_name, specs, product_price, quantity) VALUES
(1, 1, 1, 'iPhone 15 Pro', '{"color": "原色钛金属", "storage": "256GB"}', 7999.00, 1),
(2, 43, 43, 'Logitech G502', '{"color": "黑色"}', 299.00, 1),
(3, 6, 6, 'MacBook Pro 14', '{"color": "深空黑", "chip": "M3 Max"}', 14999.00, 1);

-- 7. 插入销售统计
INSERT INTO `sales_report` (date, total_sales, total_orders) VALUES
(DATE_SUB(CURDATE(), INTERVAL 1 DAY), 15000.00, 5),
(DATE_SUB(CURDATE(), INTERVAL 2 DAY), 23000.00, 8),
(DATE_SUB(CURDATE(), INTERVAL 3 DAY), 12000.00, 4),
(DATE_SUB(CURDATE(), INTERVAL 4 DAY), 35000.00, 12),
(DATE_SUB(CURDATE(), INTERVAL 5 DAY), 18000.00, 6);

-- 初始化管理员
INSERT INTO `admin_user` (`username`, `password`) VALUES ('admin', '123456');
