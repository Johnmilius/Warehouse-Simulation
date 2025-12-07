import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))
from config import DB_CONFIG
from utils import read_and_execute_sql_file, get_db_connection

import mysql.connector
from mysql.connector import Error

# Get the project root directory
PROJECT_ROOT = Path(__file__).parent.parent

DB_SETUP_FILES = {
    'schema': PROJECT_ROOT / 'database' / 'schema' / 'schema.sql',
    'seed_warehouses': PROJECT_ROOT / 'database' / 'seeds' / 'seed_warehouse_config.sql',
    'seed_locations': PROJECT_ROOT / 'database' / 'seeds' / 'seed_locations.sql',
    'seed_products': PROJECT_ROOT / 'database' / 'seeds' / 'seed_products.sql'
}

DB_VERIFICATION_FILES = {
    'db_verifications': PROJECT_ROOT / 'database' / 'verifications' / 'db_verifications.sql'
}

def db_setup():
    connection = get_db_connection()
    
    if connection is None:
        print("Failed to connect to database. Is MySQL running?")
        return
    
    try:
        for name, file_path in DB_SETUP_FILES.items():
            print(f"Executing {name}: {file_path}")
            success = read_and_execute_sql_file(str(file_path), connection)
            if not success:
                raise RuntimeError("Database Execution Error, Execution Halted")
            
    except Exception as e:    
        print(f"Database setup error: {e}")
        raise
    
    finally:
        if connection and connection.is_connected():
            connection.close()
            
def db_verification():
    connection = get_db_connection()
    
    if connection is None:
        print("Failed to connect to database. Is MySQL running?")
        return
    
    try:        
        for name, file_path in DB_VERIFICATION_FILES.items():
            print(f"Executing {name}: {file_path}")
            success = read_and_execute_sql_file(str(file_path), connection)
            if not success:
                raise RuntimeError("Database Verification Error, Execution Halted")
                
    except Exception as e:
        print(f"Database verification error: {e}")
        raise
    
    finally:
        if connection and connection.is_connected():
            connection.close()


def main():
    db_setup()
    print("\n=== Database setup completed successfully! ===\n")
    
    # Run verifications (non-fatal)
    try:
        db_verification()
        print("\n=== Database verification completed successfully! ===\n")
    except Exception as e:
        print(f"\n=== Database verification had errors (non-fatal): {e} ===\n")
        print("Database is set up, but some verification queries failed.")

if __name__ == "__main__":
    main()