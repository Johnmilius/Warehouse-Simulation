-- =====================================================
-- LOCATION GENERATOR SCRIPT
-- Generates ALL warehouse locations (~5,000 records)
-- =====================================================
-- WAREHOUSE 1 BREAKDOWN:
-- Section A: Aisles 2-25 (24 aisles) × Bays 1-18 × Levels 1-5 = 2,160 locations
-- Section B: Aisles 2-25 (24 aisles) × Bays 1-18 × Levels 1-5 = 2,160 locations
-- Section C: Aisles 2-25 (24 aisles) × Bays 1-8 × Levels 1-3 = 576 locations
-- WAREHOUSE 2 BREAKDOWN:
-- Yellow: Aisles 1-20 = 20 locations
-- Red: Aisles 1-20 = 20 locations
-- Blue: Aisles 1-10 = 10 locations
-- White: Aisles 1-20 = 20 locations
-- TOTAL: 4,966 locations
-- =====================================================

USE `lola-blanketsV2_db`;

-- =====================================================
-- WAREHOUSE 1, SECTION A
-- Aisles 2-25, Bays 1-18, Levels 1-5
-- =====================================================
INSERT INTO location (fk_location_location_warehouse, fk_location_location_section, fk_location_location_aisle, fk_location_location_bay, fk_location_location_level)
SELECT 
    1 as warehouse_id,  -- Warehouse 1
    1 as section_id,    -- Section A
    a.id as aisle_id,
    b.id as bay_id,
    l.id as level_id
FROM location_aisle a
CROSS JOIN location_bay b
CROSS JOIN location_level l
WHERE a.aisle_name BETWEEN '02' AND '25'  -- Aisles 2-25
  AND b.bay_name BETWEEN '01' AND '18'    -- Bays 1-18
  AND l.level_name BETWEEN '1' AND '5';   -- Levels 1-5

-- =====================================================
-- WAREHOUSE 1, SECTION B
-- Aisles 2-25, Bays 1-18, Levels 1-5 (identical to A)
-- =====================================================
INSERT INTO location (fk_location_location_warehouse, fk_location_location_section, fk_location_location_aisle, fk_location_location_bay, fk_location_location_level)
SELECT 
    1 as warehouse_id,  -- Warehouse 1
    2 as section_id,    -- Section B
    a.id as aisle_id,
    b.id as bay_id,
    l.id as level_id
FROM location_aisle a
CROSS JOIN location_bay b
CROSS JOIN location_level l
WHERE a.aisle_name BETWEEN '02' AND '25'  -- Aisles 2-25
  AND b.bay_name BETWEEN '01' AND '18'    -- Bays 1-18
  AND l.level_name BETWEEN '1' AND '5';   -- Levels 1-5

-- =====================================================
-- WAREHOUSE 1, SECTION C
-- Aisles 2-25, Bays 1-8, Levels 1-3
-- =====================================================
INSERT INTO location (fk_location_location_warehouse, fk_location_location_section, fk_location_location_aisle, fk_location_location_bay, fk_location_location_level)
SELECT 
    1 as warehouse_id,  -- Warehouse 1
    3 as section_id,    -- Section C
    a.id as aisle_id,
    b.id as bay_id,
    l.id as level_id
FROM location_aisle a
CROSS JOIN location_bay b
CROSS JOIN location_level l
WHERE a.aisle_name BETWEEN '02' AND '25'  -- Aisles 2-25
  AND b.bay_name BETWEEN '01' AND '08'    -- Bays 1-8 (only 8!)
  AND l.level_name BETWEEN '1' AND '3';   -- Levels 1-3 (only 3!)

-- =====================================================
-- WAREHOUSE 2, YELLOW SECTION
-- Aisles 1-20, No Bays, No Levels
-- =====================================================
INSERT INTO location (fk_location_location_warehouse, fk_location_location_section, fk_location_location_aisle, fk_location_location_bay, fk_location_location_level)
SELECT 
    2 as warehouse_id,  -- Warehouse 2
    4 as section_id,    -- Yellow Section
    a.id as aisle_id,
    NULL as bay_id,     -- No bays
    NULL as level_id    -- No levels
FROM location_aisle a
WHERE a.aisle_name BETWEEN '01' AND '20';  -- Aisles 1-20

-- =====================================================
-- WAREHOUSE 2, RED SECTION
-- Aisles 1-20, No Bays, No Levels
-- =====================================================
INSERT INTO location (fk_location_location_warehouse, fk_location_location_section, fk_location_location_aisle, fk_location_location_bay, fk_location_location_level)
SELECT 
    2 as warehouse_id,  -- Warehouse 2
    5 as section_id,    -- Red Section
    a.id as aisle_id,
    NULL as bay_id,     -- No bays
    NULL as level_id    -- No levels
FROM location_aisle a
WHERE a.aisle_name BETWEEN '01' AND '20';  -- Aisles 1-20

-- =====================================================
-- WAREHOUSE 2, BLUE SECTION
-- Aisles 1-10, No Bays, No Levels
-- =====================================================
INSERT INTO location (fk_location_location_warehouse, fk_location_location_section, fk_location_location_aisle, fk_location_location_bay, fk_location_location_level)
SELECT 
    2 as warehouse_id,  -- Warehouse 2
    6 as section_id,    -- Blue Section
    a.id as aisle_id,
    NULL as bay_id,     -- No bays
    NULL as level_id    -- No levels
FROM location_aisle a
WHERE a.aisle_name BETWEEN '01' AND '10';  -- Aisles 1-10 (only 10!)

-- =====================================================
-- WAREHOUSE 2, WHITE SECTION
-- Aisles 1-20, No Bays, No Levels
-- =====================================================
INSERT INTO location (fk_location_location_warehouse, fk_location_location_section, fk_location_location_aisle, fk_location_location_bay, fk_location_location_level)
SELECT 
    2 as warehouse_id,  -- Warehouse 2
    7 as section_id,    -- White Section
    a.id as aisle_id,
    NULL as bay_id,     -- No bays
    NULL as level_id    -- No levels
FROM location_aisle a
WHERE a.aisle_name BETWEEN '01' AND '20';  -- Aisles 1-20