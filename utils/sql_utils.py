import mysql.connector
from mysql.connector import Error
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))
from config import DB_CONFIG

def get_db_connection(config = None):
    
    cfg = config or DB_CONFIG
    
    try: 
        connection = mysql.connector.connect(**cfg)
        return connection
    except Exception as e:
        print(f"Error trying to connect to MySQL: {e}")
        print(f"Config: {cfg}")
        raise
        
def sql_query_statement(connection, query, data=None, fetchall=False, fetchone=False):
   
    try:
        cursor = connection.cursor()
        cursor.execute(query, data)

        if fetchone:
            result = cursor.fetchone()
        elif fetchall:
            result = cursor.fetchall()
        else:
            connection.commit() 

        return result
    
    except Exception as e:
        print(f"Error: {e}\nWith Executing Query:\n{query}\nWith Data: {data}")
        raise
    finally:
        if cursor:
            cursor.close()
        
def sql_insert_statement(connection, insert, data, execute_many=False):
    
    try: 
        cursor = connection.cursor()

        if execute_many:
            cursor.executemany(insert, data)
        else:
            cursor.execute(insert, data)
        connection.commit()
        return cursor.lastrowid
    
    except Exception as e:
        print(f"Error: {e}\nInserting:\n{insert}\nWith data:\n{data}")
        raise
        
    finally:
        if cursor:
            cursor.close()
    
    
    
    