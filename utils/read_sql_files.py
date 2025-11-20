from config import DB_CONFIG
import mysql.connector

def read_and_execute_sql_file(filepath, connection):
    
    try: 
        # open the file read to a string
        with open(filepath, 'r') as file:
            sql_content = file.read() 
        print(f"Successfull Reading file {filepath}: contains{sql_content[:100]}...")
            
    except Exception as e:
        print(f"Error Reading file {filepath}")
        return False
        
       
    try: 
        # connects to the line
        cursor = connection.cursor()
        
        # executes the code
        cursor.execute(sql_content)
        connection.commit()
        
        # debug statement
        print(f"SQL file {filepath} executed succesfully.")
        return True
    except Exception as e:
        print(f"SQL file had error being read: {e}") ## finish this function
        return False
    