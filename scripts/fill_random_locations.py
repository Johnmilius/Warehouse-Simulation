import mysql.connector
from mysql.connector import Error
import random
from datetime import datetime, timedelta
from decimal import Decimal
from config import BLANKET_TYPES, SIZES, DB_CONFIG

#  Business Code   -    Product ID   -   Size Blanket 
#      302         -       1077      -       01, 02, 03, 04
#     Lola             Antique Ivory        Baby, Medium, Large, X-Large
# e.g. 302-1077-02

# 4,966 Locations
# Warehouse 1 - 4,896 (higher locations less space) 1 pallet per location. [exceptions being level 5 locations since there is nothing above them they can hold a few extra boxes]
# Warehouse 2 - 70 (much larger capacity) roughly 15 pallets each so it grows to be a lot larger

# Baby boxes hold 10 per box
# Medium + Large boxes hold 4 blankets per
# Extra Large boxes hold 2 blankets per box

# Baby Hold 180 blankets per location (pallet), 18 Boxes 2 X 3 X 3 
# Medium Hold 72 blankets per location (pallet), 18 Boxes 2 X 3 X 3
# Large Hold 48 blankets per location (pallet), 12 Boxes 2 X 2 x 3
# Extra Large Hold 32 blankets per location (pallet), 16 boxes 2 X 4 X 2

# IDEAL keep warehouse locations at 75% full


def generate_inventory_count_warehouse_1(connection):
    PRODUCTS = get_all_product_info(connection)
    filled_locations = []
    
    all_empty_locations = list(get_all_empty_locations(connection))
    random.shuffle(all_empty_locations)
    
    while (1 - (len(all_empty_locations) / DB_CONFIG['TOTAL_NUMBER_LOCATIONS_WAREHOUSE_1']) < .75):
        empty_location_id = all_empty_locations.pop(0)[0]
        product = get_random_product(PRODUCTS) # (id, name, sku)
        stock_quantity = generate_random_product_stock_count(product[2])

        filled_locations.append((product[0], empty_location_id, stock_quantity, datetime.now()))
    
    return filled_locations
        
        
def insert_many(tablename, data, connection):
    try:
        cursor = connection.cursor()
        
        insert_query = """
            INSERT INTO product_location (fk_product_location_product, fk_product_location_location, quantity, last_update)
            VALUES (%s, %s, %s, %s)
        """
        
        cursor.executemany(insert_query, data)
        connection.commit()
    except Error as e:
        print(f"Error inserting data: {e}")


def get_all_empty_locations(connection):
    cursor = connection.cursor()
    
    query = """
        SELECT l.id
        FROM location l
        LEFT JOIN product_location pl ON l.id = pl.fk_product_location_location
        WHERE pl.id IS NULL
    """
    
    cursor.execute(query)
    
    results = cursor.fetchall()
    
    cursor.close()
    return results

def get_all_product_info(connection):
    cursor = connection.cursor()
    
    query = """
        SELECT p.id as 'id',
        p.name as 'name',
        p.sku as 'sku'
        from product as p;    
    """
    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()

    return results

def get_random_product(products):
    product = random.choice(products)
    return product

def generate_random_product_stock_count(sku):
    size = sku[9:11]
    pallet_box_count = SIZES[size]["boxes_per_pallet"]
    blankets_per_box = SIZES[size]["blankets_per_box"]
    random_box_count = random.randint(1, pallet_box_count)
    
    random_blanket_count = random_box_count * blankets_per_box
    
    return random_blanket_count





def main():
    connection = mysql.connector.connect(**DB_CONFIG)

    filled_inventory_data = generate_inventory_count_warehouse_1(connection)
    insert_many("product_location", filled_inventory_data, connection)
    
    connection.close()

if __name__ == '__main__':
    main()
    