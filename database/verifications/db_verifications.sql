-- =====================================================
-- VERIFICATION: Check what we created
-- Building Blocks
-- =====================================================
SELECT 'Building blocks loaded successfully!' as Status;
SELECT COUNT(*) as warehouse_count FROM location_warehouse;
SELECT COUNT(*) as section_count FROM location_section;
SELECT COUNT(*) as aisle_count FROM location_aisle;
SELECT COUNT(*) as bay_count FROM location_bay;
SELECT COUNT(*) as level_count FROM location_level;




-- =====================================================
-- VERIFICATION QUERIES
-- Locations
-- =====================================================
SELECT 'All locations generated successfully!' as Status;

-- Count locations by warehouse and section
SELECT 
    w.warehouse_name,
    s.section_name,
    COUNT(l.id) as location_count
FROM location l
JOIN location_warehouse w ON l.fk_location_location_warehouse = w.id
JOIN location_section s ON l.fk_location_location_section = s.id
GROUP BY w.id, s.id
ORDER BY w.id, s.id;

-- Total location count
SELECT COUNT(*) as total_locations FROM location;

-- Show sample locations from each section
SELECT 
    'W1-Section A' as sample_section,
    w.warehouse_name,
    s.section_name,
    a.aisle_name,
    b.bay_name,
    lv.level_name
FROM location l
JOIN location_warehouse w ON l.fk_location_location_warehouse = w.id
JOIN location_section s ON l.fk_location_location_section = s.id
JOIN location_aisle a ON l.fk_location_location_aisle = a.id
JOIN location_bay b ON l.fk_location_location_bay = b.id
JOIN location_level lv ON l.fk_location_location_level = lv.id
WHERE s.section_name = 'A'
LIMIT 5

UNION ALL

SELECT 
    'W2-Yellow' as sample_section,
    w.warehouse_name,
    s.section_name,
    a.aisle_name,
    'N/A' as bay_name,
    'N/A' as level_name
FROM location l
JOIN location_warehouse w ON l.fk_location_location_warehouse = w.id
JOIN location_section s ON l.fk_location_location_section = s.id
JOIN location_aisle a ON l.fk_location_location_aisle = a.id
WHERE s.section_name = 'Yellow'
LIMIT 5;