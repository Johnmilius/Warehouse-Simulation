import mysql.connector
from mysql.connector import Error
from datetime import datetime

import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))
from utils import get_db_connection, sql_insert_statement, sql_query_statement

from handle_shipment_receipt import process_reciept
from config import DB_CONFIG



def handle_receipt_db_insert():
    
    receipt_data = process_reciept()
    if receipt_data is None:
        print("Receipt data does not exist.")
        return None
        
    try: 
        connection = mysql.connector.connect(**DB_CONFIG)
            
        shipment_receipt_insert_statement = """
        INSERT INTO shipment_receipt (
        po_number,
        shipment_date,
        expected_date,
        received_date,
        status,
        supplier_name,
        carrier,
        tracking_number,
        total_pallets,
        notes,
        created_date)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
        """
        
        shipment_receipt_tuple = (
        receipt_data['po_number'],
        receipt_data['shipment_date'],
        receipt_data['expected_date'],
        datetime.now(), # Received Date
        "RECEIVED", # Status
        receipt_data['supplier_name'],
        receipt_data['carrier'],
        receipt_data['tracking_number'],
        int(receipt_data['total_pallets']),
        receipt_data['notes'],
        datetime.now() # Create_date
        )
        
        shipment_receipt_lastrowid = sql_insert_statement(connection=connection,
                                                        insert=shipment_receipt_insert_statement,
                                                        data=shipment_receipt_tuple)
            
        shipment_receipt_item_insert_statement = """
        INSERT INTO shipment_receipt_item (
        fk_shipment_receipt,
        fk_product,
        quantity_expected,
        quantity_received,
        pallets_expected,
        pallets_received,
        status,
        notes,
        received_date
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);
        """
        
        for item in receipt_data['shipment_items']:
        
            query_product_id = "SELECT id from product WHERE sku = %s"
            fk_product = sql_query_statement(connection=connection,
                                                query=query_product_id, 
                                                data=(item['sku'],),
                                                fetchone=True)
            
            print(f"\n\n\n{fk_product}\n\n\n")
            
            # shipment quantity logic 
            if  item['quantity_received'] < item['quantity_expected']:
              shipment_item_status = 'SHORT'
            elif item['quantity_received'] > item['quantity_expected']:
              shipment_item_status = 'OVER'
            else:
              shipment_item_status = 'RECEIVED'
            
            shipment_receipt_item_tuple = (
            shipment_receipt_lastrowid,
            fk_product[0],
            item['quantity_expected'],
            item['quantity_received'],
            item['pallets_expected'],
            item['pallets_received'],
            shipment_item_status,
            item['notes'],
            datetime.now(), # date_received.
            )
                
            sql_insert_statement(connection=connection,
                                insert=shipment_receipt_item_insert_statement, 
                                data=shipment_receipt_item_tuple)
            
    finally:   
        connection.close()

handle_receipt_db_insert()


# Example table structure
{
  "shipment_receipt": {
    "columns": {
      "id": "INT UNSIGNED AUTO_INCREMENT PRIMARY KEY",
      "po_number": "VARCHAR(45) UNIQUE",
      "shipment_date": "DATE",
      "expected_date": "DATE NULL",
      "received_date": "TIMESTAMP NULL", # Create
      "status": "ENUM('PENDING', 'IN_TRANSIT', 'RECEIVING', 'RECEIVED', 'CLOSED') DEFAULT 'PENDING'", # Create
      "supplier_name": "VARCHAR(100) NULL",
      "carrier": "VARCHAR(100) NULL",
      "tracking_number": "VARCHAR(100) NULL",
      "total_pallets": "INT UNSIGNED NULL",
      "notes": "TEXT NULL",
      "created_date": "TIMESTAMP DEFAULT CURRENT_TIMESTAMP" # Create
    },
    "indexes": [
      "PRIMARY KEY (id)",
      "UNIQUE (po_number)",
      "INDEX (status)",
      "INDEX (received_date)"
    ]
  },

  "shipment_receipt_item": {
    "columns": {
      "id": "INT UNSIGNED AUTO_INCREMENT PRIMARY KEY",
      "fk_shipment_receipt": "INT UNSIGNED",
      "fk_product": "INT UNSIGNED",
      "quantity_expected": "INT UNSIGNED",
      "quantity_received": "INT UNSIGNED DEFAULT 0",
      "pallets_expected": "INT UNSIGNED",
      "pallets_received": "INT UNSIGNED DEFAULT 0",
      "status": "ENUM('PENDING', 'RECEIVED', 'SHORT', 'OVER', 'DAMAGED') DEFAULT 'PENDING'",
      "notes": "TEXT NULL",
      "received_date": "TIMESTAMP NULL"
    },
    "indexes": [
      "INDEX (fk_shipment_receipt)",
      "INDEX (fk_product)",
      "INDEX (status)"
    ],
    "foreign_keys": {
      "fk_shipment_receipt": "REFERENCES shipment_receipt(id) ON DELETE CASCADE",
      "fk_product": "REFERENCES product(id) ON DELETE NO ACTION"
    }
  },

  "inventory_unit": {
    "new_columns": {
      "fk_shipment_receipt_item": "INT UNSIGNED NULL"
    },
    "indexes": [
      "INDEX (fk_shipment_receipt_item)"
    ],
    "foreign_keys": {
      "fk_shipment_receipt_item": "REFERENCES shipment_receipt_item(id) ON DELETE SET NULL"
    }
  }
}
