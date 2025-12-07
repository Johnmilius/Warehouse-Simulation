-- =====================================================
-- LOLA BLANKETS WAREHOUSE SAMPLE DATA
-- =====================================================
-- This script populates the database with a real warehouse layout
-- Warehouse 1: Sections A, B (Aisles 2-25, Bays 1-18, Levels 1-5)
--              Section C (Bays 1-8, Levels 1-3)
-- Warehouse 2: Sections Yellow, Red, White (Aisles 1-20)
--              Section Blue (Aisles 1-10)
--              No Bays, No Levels
-- =====================================================

USE `lola-blanketsV2_db`;
-- Clear existing data (if re-running script)
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE inventory_transaction;
TRUNCATE TABLE product_location;
TRUNCATE TABLE location;
TRUNCATE TABLE location_bay;
TRUNCATE TABLE location_level;
TRUNCATE TABLE location_aisle;
TRUNCATE TABLE location_section;
TRUNCATE TABLE location_warehouse;
TRUNCATE TABLE product;
SET FOREIGN_KEY_CHECKS=1;

-- =====================================================
-- STEP 1: CREATE WAREHOUSES
-- =====================================================
INSERT INTO location_warehouse (warehouse_name, description) VALUES
('Warehouse 1', 'Main warehouse with sections A, B, C'),
('Warehouse 2', 'Color-coded warehouse with Yellow, Red, Blue, White sections');

-- =====================================================
-- STEP 2: CREATE SECTIONS
-- =====================================================
-- Warehouse 1 Sections
INSERT INTO location_section (section_name, description) VALUES
('A', 'Warehouse 1 - Section A (Aisles 2-25, Bays 1-18, Levels 1-5)'),
('B', 'Warehouse 1 - Section B (Aisles 2-25, Bays 1-18, Levels 1-5)'),
('C', 'Warehouse 1 - Section C (Bays 1-8, Levels 1-3)'),
-- Warehouse 2 Sections
('Yellow', 'Warehouse 2 - Yellow Section (Aisles 1-20)'),
('Red', 'Warehouse 2 - Red Section (Aisles 1-20)'),
('Blue', 'Warehouse 2 - Blue Section (Aisles 1-10)'),
('White', 'Warehouse 2 - White Section (Aisles 1-20)');

-- =====================================================
-- STEP 3: CREATE AISLES
-- =====================================================
-- Warehouse 1: Aisles 2-25 (for sections A, B, C)
INSERT INTO location_aisle (aisle_name, description) VALUES
('02', 'Aisle 2'), ('03', 'Aisle 3'), ('04', 'Aisle 4'), ('05', 'Aisle 5'),
('06', 'Aisle 6'), ('07', 'Aisle 7'), ('08', 'Aisle 8'), ('09', 'Aisle 9'),
('10', 'Aisle 10'), ('11', 'Aisle 11'), ('12', 'Aisle 12'), ('13', 'Aisle 13'),
('14', 'Aisle 14'), ('15', 'Aisle 15'), ('16', 'Aisle 16'), ('17', 'Aisle 17'),
('18', 'Aisle 18'), ('19', 'Aisle 19'), ('20', 'Aisle 20'), ('21', 'Aisle 21'),
('22', 'Aisle 22'), ('23', 'Aisle 23'), ('24', 'Aisle 24'), ('25', 'Aisle 25');

-- Warehouse 2: Aisles 1-20
INSERT INTO location_aisle (aisle_name, description) VALUES
('01', 'Aisle 1');

-- =====================================================
-- STEP 4: CREATE BAYS (1-18 for W1 sections A&B, 1-8 for W1 section C)
-- =====================================================
INSERT INTO location_bay (bay_name, description) VALUES
('01', 'Bay 1'), ('02', 'Bay 2'), ('03', 'Bay 3'), ('04', 'Bay 4'),
('05', 'Bay 5'), ('06', 'Bay 6'), ('07', 'Bay 7'), ('08', 'Bay 8'),
('09', 'Bay 9'), ('10', 'Bay 10'), ('11', 'Bay 11'), ('12', 'Bay 12'),
('13', 'Bay 13'), ('14', 'Bay 14'), ('15', 'Bay 15'), ('16', 'Bay 16'),
('17', 'Bay 17'), ('18', 'Bay 18');

-- =====================================================
-- STEP 5: CREATE LEVELS (1-5 for W1 sections A&B, 1-3 for W1 section C)
-- =====================================================
INSERT INTO location_level (level_name, description) VALUES
('1', 'Level 1 - Ground'),
('2', 'Level 2'),
('3', 'Level 3'),
('4', 'Level 4'),
('5', 'Level 5 - Top');