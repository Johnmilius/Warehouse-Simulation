USE `lola-blankets_db`;
SELECT 'Connection successful!' as Status;

-- =====================================================
-- VERIFICATION: Check what we created
-- =====================================================
SELECT 'Building blocks loaded successfully!' as Status;
SELECT COUNT(*) as warehouse_count FROM location_warehouse;
SELECT COUNT(*) as section_count FROM location_section;
SELECT COUNT(*) as aisle_count FROM location_aisle;
SELECT COUNT(*) as bay_count FROM location_bay;
SELECT COUNT(*) as level_count FROM location_level;