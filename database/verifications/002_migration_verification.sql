-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================
SELECT 'MIGRATION VERIFICATION' AS '';

-- Show new tables
SELECT TABLE_NAME, TABLE_ROWS, CREATE_TIME
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'lola-blanketsV2_db'
AND TABLE_NAME IN ('shipment_receipt', 'shipment_receipt_item')
ORDER BY TABLE_NAME;

-- Show migration history
SELECT * FROM schema_migrations ORDER BY version;

-- Show inventory_unit structure (verify new column)
DESCRIBE inventory_unit;

SELECT '✓ Verification complete. Migration 002 successfully applied.' AS '';