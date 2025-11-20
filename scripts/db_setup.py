from config import DB_CONFIG
from utils import read_and_execute_sql_file
import mysql.connector
from mysql.connector import Error


DB_SETUP_FILES = {
    'schema':'../database/schema.sql',
    'seed_warehouses':'../database/seed_warehouse_config.sql',
    'seed_locations':'../database/see_locations.sql',
    'seed_products':'../database/seed_products.sql'
}

DB_VERIFICATION_FILES = {
    'db_verifications':'../database/db_verifications.sql'
}

def db_setup():
    connection = None
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        
        for file in DB_SETUP_FILES:
            success =  read_and_execute_sql_file(file, connection)
            if not success:
                raise RuntimeError("Database Execution Error, Execution Halted")
            
    except Exception as e:    
        print(f"Database setup error: {e}")
        raise
    
    finally:
        if connection and connection.is_connected():
            connection.close()
            
def db_verification():
    connection = None
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        
        for file_path in DB_VERIFICATION_FILES.values():
            success = read_and_execute_sql_file(file_path, connection)
            if not success:
                raise RuntimeError("Database Verification Error, Execution Halted")
                
    except Exception as e:
        print(f"Database verification error: {e}")
        raise
    finally:
        if connection and connection.is_connected():
            connection.close()
