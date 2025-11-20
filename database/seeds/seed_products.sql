-- =====================================================
-- INSERT ALL LOLA BLANKET PRODUCTS
-- =====================================================
-- 19 Blanket Types × 4 Sizes = 76 Total Products
-- Business Code: 302 (Lola)
-- Cost: $50 (all sizes)
-- Prices: Baby $109, Medium $249, Large $299, XL $399
-- =====================================================

USE `lola-blankets_db`;

-- Clear existing products if re-running
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE inventory_transaction;
TRUNCATE TABLE product_location;
TRUNCATE TABLE product;
SET FOREIGN_KEY_CHECKS=1;

-- Insert all products
INSERT INTO product (name, sku, description, cost, price) VALUES
-- Caramel N' Cream (1001)
('Lola Caramel N'' Cream - Baby', '302-1001-01', 'Baby size Caramel N'' Cream blanket', 50.00, 109.00),
('Lola Caramel N'' Cream - Medium', '302-1001-02', 'Medium size Caramel N'' Cream blanket', 50.00, 249.00),
('Lola Caramel N'' Cream - Large', '302-1001-03', 'Large size Caramel N'' Cream blanket', 50.00, 299.00),
('Lola Caramel N'' Cream - Extra Large', '302-1001-04', 'Extra Large size Caramel N'' Cream blanket', 50.00, 399.00),

-- Antique Ivory (1002)
('Lola Antique Ivory - Baby', '302-1002-01', 'Baby size Antique Ivory blanket', 50.00, 109.00),
('Lola Antique Ivory - Medium', '302-1002-02', 'Medium size Antique Ivory blanket', 50.00, 249.00),
('Lola Antique Ivory - Large', '302-1002-03', 'Large size Antique Ivory blanket', 50.00, 299.00),
('Lola Antique Ivory - Extra Large', '302-1002-04', 'Extra Large size Antique Ivory blanket', 50.00, 399.00),

-- Creamy Cloud (1003)
('Lola Creamy Cloud - Baby', '302-1003-01', 'Baby size Creamy Cloud blanket', 50.00, 109.00),
('Lola Creamy Cloud - Medium', '302-1003-02', 'Medium size Creamy Cloud blanket', 50.00, 249.00),
('Lola Creamy Cloud - Large', '302-1003-03', 'Large size Creamy Cloud blanket', 50.00, 299.00),
('Lola Creamy Cloud - Extra Large', '302-1003-04', 'Extra Large size Creamy Cloud blanket', 50.00, 399.00),

-- Desert Dune (1004)
('Lola Desert Dune - Baby', '302-1004-01', 'Baby size Desert Dune blanket', 50.00, 109.00),
('Lola Desert Dune - Medium', '302-1004-02', 'Medium size Desert Dune blanket', 50.00, 249.00),
('Lola Desert Dune - Large', '302-1004-03', 'Large size Desert Dune blanket', 50.00, 299.00),
('Lola Desert Dune - Extra Large', '302-1004-04', 'Extra Large size Desert Dune blanket', 50.00, 399.00),

-- Smoky Skies (1005)
('Lola Smoky Skies - Baby', '302-1005-01', 'Baby size Smoky Skies blanket', 50.00, 109.00),
('Lola Smoky Skies - Medium', '302-1005-02', 'Medium size Smoky Skies blanket', 50.00, 249.00),
('Lola Smoky Skies - Large', '302-1005-03', 'Large size Smoky Skies blanket', 50.00, 299.00),
('Lola Smoky Skies - Extra Large', '302-1005-04', 'Extra Large size Smoky Skies blanket', 50.00, 399.00),

-- Blush Pink (1006)
('Lola Blush Pink - Baby', '302-1006-01', 'Baby size Blush Pink blanket', 50.00, 109.00),
('Lola Blush Pink - Medium', '302-1006-02', 'Medium size Blush Pink blanket', 50.00, 249.00),
('Lola Blush Pink - Large', '302-1006-03', 'Large size Blush Pink blanket', 50.00, 299.00),
('Lola Blush Pink - Extra Large', '302-1006-04', 'Extra Large size Blush Pink blanket', 50.00, 399.00),

-- Malibu Blue (1007)
('Lola Malibu Blue - Baby', '302-1007-01', 'Baby size Malibu Blue blanket', 50.00, 109.00),
('Lola Malibu Blue - Medium', '302-1007-02', 'Medium size Malibu Blue blanket', 50.00, 249.00),
('Lola Malibu Blue - Large', '302-1007-03', 'Large size Malibu Blue blanket', 50.00, 299.00),
('Lola Malibu Blue - Extra Large', '302-1007-04', 'Extra Large size Malibu Blue blanket', 50.00, 399.00),

-- Midnight Marie (1008)
('Lola Midnight Marie - Baby', '302-1008-01', 'Baby size Midnight Marie blanket', 50.00, 109.00),
('Lola Midnight Marie - Medium', '302-1008-02', 'Medium size Midnight Marie blanket', 50.00, 249.00),
('Lola Midnight Marie - Large', '302-1008-03', 'Large size Midnight Marie blanket', 50.00, 299.00),
('Lola Midnight Marie - Extra Large', '302-1008-04', 'Extra Large size Midnight Marie blanket', 50.00, 399.00),

-- Rainy Day (1009)
('Lola Rainy Day - Baby', '302-1009-01', 'Baby size Rainy Day blanket', 50.00, 109.00),
('Lola Rainy Day - Medium', '302-1009-02', 'Medium size Rainy Day blanket', 50.00, 249.00),
('Lola Rainy Day - Large', '302-1009-03', 'Large size Rainy Day blanket', 50.00, 299.00),
('Lola Rainy Day - Extra Large', '302-1009-04', 'Extra Large size Rainy Day blanket', 50.00, 399.00),

-- Rosewater (1010)
('Lola Rosewater - Baby', '302-1010-01', 'Baby size Rosewater blanket', 50.00, 109.00),
('Lola Rosewater - Medium', '302-1010-02', 'Medium size Rosewater blanket', 50.00, 249.00),
('Lola Rosewater - Large', '302-1010-03', 'Large size Rosewater blanket', 50.00, 299.00),
('Lola Rosewater - Extra Large', '302-1010-04', 'Extra Large size Rosewater blanket', 50.00, 399.00),

-- Chillin' Cheetah (1011)
('Lola Chillin'' Cheetah - Baby', '302-1011-01', 'Baby size Chillin'' Cheetah blanket', 50.00, 109.00),
('Lola Chillin'' Cheetah - Medium', '302-1011-02', 'Medium size Chillin'' Cheetah blanket', 50.00, 249.00),
('Lola Chillin'' Cheetah - Large', '302-1011-03', 'Large size Chillin'' Cheetah blanket', 50.00, 299.00),
('Lola Chillin'' Cheetah - Extra Large', '302-1011-04', 'Extra Large size Chillin'' Cheetah blanket', 50.00, 399.00),

-- Latte Check (1012)
('Lola Latte Check - Baby', '302-1012-01', 'Baby size Latte Check blanket', 50.00, 109.00),
('Lola Latte Check - Medium', '302-1012-02', 'Medium size Latte Check blanket', 50.00, 249.00),
('Lola Latte Check - Large', '302-1012-03', 'Large size Latte Check blanket', 50.00, 299.00),
('Lola Latte Check - Extra Large', '302-1012-04', 'Extra Large size Latte Check blanket', 50.00, 399.00),

-- Mocha Check (1013)
('Lola Mocha Check - Baby', '302-1013-01', 'Baby size Mocha Check blanket', 50.00, 109.00),
('Lola Mocha Check - Medium', '302-1013-02', 'Medium size Mocha Check blanket', 50.00, 249.00),
('Lola Mocha Check - Large', '302-1013-03', 'Large size Mocha Check blanket', 50.00, 299.00),
('Lola Mocha Check - Extra Large', '302-1013-04', 'Extra Large size Mocha Check blanket', 50.00, 399.00),

-- Toasted Almond (1014)
('Lola Toasted Almond - Baby', '302-1014-01', 'Baby size Toasted Almond blanket', 50.00, 109.00),
('Lola Toasted Almond - Medium', '302-1014-02', 'Medium size Toasted Almond blanket', 50.00, 249.00),
('Lola Toasted Almond - Large', '302-1014-03', 'Large size Toasted Almond blanket', 50.00, 299.00),
('Lola Toasted Almond - Extra Large', '302-1014-04', 'Extra Large size Toasted Almond blanket', 50.00, 399.00),

-- Peaches & Cream (1015)
('Lola Peaches & Cream - Baby', '302-1015-01', 'Baby size Peaches & Cream blanket', 50.00, 109.00),
('Lola Peaches & Cream - Medium', '302-1015-02', 'Medium size Peaches & Cream blanket', 50.00, 249.00),
('Lola Peaches & Cream - Large', '302-1015-03', 'Large size Peaches & Cream blanket', 50.00, 299.00),
('Lola Peaches & Cream - Extra Large', '302-1015-04', 'Extra Large size Peaches & Cream blanket', 50.00, 399.00),

-- Huckleberry Harvest (1016)
('Lola Huckleberry Harvest - Baby', '302-1016-01', 'Baby size Huckleberry Harvest blanket', 50.00, 109.00),
('Lola Huckleberry Harvest - Medium', '302-1016-02', 'Medium size Huckleberry Harvest blanket', 50.00, 249.00),
('Lola Huckleberry Harvest - Large', '302-1016-03', 'Large size Huckleberry Harvest blanket', 50.00, 299.00),
('Lola Huckleberry Harvest - Extra Large', '302-1016-04', 'Extra Large size Huckleberry Harvest blanket', 50.00, 399.00),

-- Silver Linings (1017)
('Lola Silver Linings - Baby', '302-1017-01', 'Baby size Silver Linings blanket', 50.00, 109.00),
('Lola Silver Linings - Medium', '302-1017-02', 'Medium size Silver Linings blanket', 50.00, 249.00),
('Lola Silver Linings - Large', '302-1017-03', 'Large size Silver Linings blanket', 50.00, 299.00),
('Lola Silver Linings - Extra Large', '302-1017-04', 'Extra Large size Silver Linings blanket', 50.00, 399.00),

-- Navy Blue (1018)
('Lola Navy Blue - Baby', '302-1018-01', 'Baby size Navy Blue blanket', 50.00, 109.00),
('Lola Navy Blue - Medium', '302-1018-02', 'Medium size Navy Blue blanket', 50.00, 249.00),
('Lola Navy Blue - Large', '302-1018-03', 'Large size Navy Blue blanket', 50.00, 299.00),
('Lola Navy Blue - Extra Large', '302-1018-04', 'Extra Large size Navy Blue blanket', 50.00, 399.00),

-- Charcoal Grey (1019)
('Lola Charcoal Grey - Baby', '302-1019-01', 'Baby size Charcoal Grey blanket', 50.00, 109.00),
('Lola Charcoal Grey - Medium', '302-1019-02', 'Medium size Charcoal Grey blanket', 50.00, 249.00),
('Lola Charcoal Grey - Large', '302-1019-03', 'Large size Charcoal Grey blanket', 50.00, 299.00),
('Lola Charcoal Grey - Extra Large', '302-1019-04', 'Extra Large size Charcoal Grey blanket', 50.00, 399.00);

-- Verification
SELECT 'Products loaded successfully!' as Status;
SELECT COUNT(*) as total_products FROM product;
SELECT name, sku, cost, price FROM product LIMIT 10;