-- =====================================================
-- MIGRATION 003: Add Shipment Tracking
-- =====================================================
-- Description: Adds shipment_receipt and shipment_receipt_item tables
--              to track inbound shipments and link to inventory_units
-- Date: 2024-11-22
-- Database: lola-blanketsV2_db
-- Dependencies: Requires inventory_unit table (from initial schema)
-- =====================================================

USE `lola-blanketsV2_db`;

-- =====================================================
-- STEP 1: Check if migration already applied
-- =====================================================
-- Create migration tracking table if it doesn't exist
CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR(10) PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Check if this migration was already applied
SELECT 
    CASE 
        WHEN EXISTS (SELECT 1 FROM schema_migrations WHERE version = '003')
        THEN 'Migration 003 already applied. Exiting.'
        ELSE 'Applying migration 003...'
    END AS status;

-- Exit if already applied (in a real tool, this would stop execution)
-- For manual running: comment out everything below if migration exists

-- =====================================================
-- STEP 2: Create shipment_receipt table
-- =====================================================
CREATE TABLE IF NOT EXISTS shipment_receipt (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    po_number VARCHAR(45) NOT NULL,
    shipment_date DATE NOT NULL,
    expected_date DATE NULL,
    received_date TIMESTAMP NULL,
    status ENUM('PENDING', 'IN_TRANSIT', 'RECEIVING', 'RECEIVED', 'CLOSED') NOT NULL DEFAULT 'PENDING',
    supplier_name VARCHAR(100) NULL,
    carrier VARCHAR(100) NULL,
    tracking_number VARCHAR(100) NULL,
    total_pallets INT UNSIGNED NULL,
    notes TEXT NULL,
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE INDEX po_number_UNIQUE (po_number ASC),
    INDEX idx_status (status),
    INDEX idx_received_date (received_date)
) ENGINE = InnoDB
COMMENT = 'Tracks inbound shipments and receiving process';

SELECT '✓ Created shipment_receipt table' AS status;

-- =====================================================
-- STEP 3: Create shipment_receipt_item table
-- =====================================================
CREATE TABLE IF NOT EXISTS shipment_receipt_item (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_shipment_receipt INT UNSIGNED NOT NULL,
    fk_product INT UNSIGNED NOT NULL,
    quantity_expected INT UNSIGNED NOT NULL,
    quantity_received INT UNSIGNED NOT NULL DEFAULT 0,
    pallets_expected INT UNSIGNED NOT NULL,
    pallets_received INT UNSIGNED NOT NULL DEFAULT 0,
    status ENUM('PENDING', 'RECEIVED', 'SHORT', 'OVER', 'DAMAGED') NOT NULL DEFAULT 'PENDING',
    notes TEXT NULL,
    received_date TIMESTAMP NULL,
    PRIMARY KEY (id),
    INDEX idx_shipment (fk_shipment_receipt),
    INDEX idx_product (fk_product),
    INDEX idx_status (status),
    CONSTRAINT fk_shipment_receipt_item_shipment
        FOREIGN KEY (fk_shipment_receipt)
        REFERENCES shipment_receipt (id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    CONSTRAINT fk_shipment_receipt_item_product
        FOREIGN KEY (fk_product)
        REFERENCES product (id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB
COMMENT = 'Line items for inbound shipments - links products to shipments';

SELECT '✓ Created shipment_receipt_item table' AS status;

-- =====================================================
-- STEP 4: Alter inventory_unit to link to shipments
-- =====================================================
-- Check if column already exists (safety check)
SET @col_exists = (
    SELECT COUNT(*) 
    FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = 'lola-blanketsV2_db' 
    AND TABLE_NAME = 'inventory_unit' 
    AND COLUMN_NAME = 'fk_shipment_receipt_item'
);

-- Add column only if it doesn't exist
SET @sql = IF(@col_exists = 0,
    'ALTER TABLE inventory_unit 
     ADD COLUMN fk_shipment_receipt_item INT UNSIGNED NULL AFTER date_received,
     ADD INDEX idx_shipment_item (fk_shipment_receipt_item),
     ADD CONSTRAINT fk_inventory_unit_shipment_item
         FOREIGN KEY (fk_shipment_receipt_item)
         REFERENCES shipment_receipt_item (id)
         ON DELETE SET NULL
         ON UPDATE NO ACTION',
    'SELECT "Column fk_shipment_receipt_item already exists" AS status'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT '✓ Updated inventory_unit table with shipment link' AS status;

-- =====================================================
-- STEP 6: Record migration as applied
-- =====================================================
INSERT INTO schema_migrations (version, description)
VALUES ('002', 'Add shipment tracking tables and link to inventory_unit')
ON DUPLICATE KEY UPDATE applied_at = CURRENT_TIMESTAMP;

SELECT '✓ Migration 002 completed successfully!' AS status;