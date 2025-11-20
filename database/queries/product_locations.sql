SELECT 
	p.id as 'ID',
    p.name as 'Product Name',
    p.sku as 'SKU Code',
    w.warehouse_name as 'Warehouse',
    s.section_name as 'Section',
    a.aisle_name as 'Aisle',
    b.bay_name as 'Bay',
    lv.level_name as 'Level',
    pl.quantity as 'Quantity'
    
FROM 
    product_location pl
INNER JOIN product p ON pl.fk_product_location_product = p.id
INNER JOIN location l ON pl.fk_product_location_location = l.id
INNER JOIN location_warehouse w ON l.fk_location_location_warehouse = w.id
INNER JOIN location_section s ON l.fk_location_location_section = s.id
INNER JOIN location_aisle a ON l.fk_location_location_aisle = a.id
LEFT JOIN location_bay b ON l.fk_location_location_bay = b.id
LEFT JOIN location_level lv ON l.fk_location_location_level = lv.id
ORDER BY p.id;
-- GROUP BY p.id, p.nam, p.sku;
