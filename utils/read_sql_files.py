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
        cursor = connection.cursor()
        
        # Remove comments and split by semicolons
        lines = sql_content.split('\n')
        cleaned_lines = []
        for line in lines:
            # Remove single-line comments
            if '--' in line:
                line = line[:line.index('--')]
            if line.strip():
                cleaned_lines.append(line)
        
        cleaned_content = '\n'.join(cleaned_lines)
        
        # Split by semicolon to get individual statements
        statements = [stmt.strip() for stmt in cleaned_content.split(';') if stmt.strip()]
        
        # Execute each statement separately
        for i, statement in enumerate(statements):
            try:
                cursor.execute(statement)
                # If the statement returns results, fetch them to clear the buffer
                if cursor.with_rows:
                    cursor.fetchall()
            except Exception as stmt_error:
                print(f"Error on statement {i+1}: {stmt_error}")
                print(f"Statement: {statement[:200]}...")
                raise
        
        connection.commit()
        
        # debug statement
        print(f"SQL file {filepath} executed successfully ({len(statements)} statements).")
        return True
    except Exception as e:
        print(f"SQL file had error being executed: {e}")
        connection.rollback()
        return False
    finally:
        if cursor:
            cursor.close()
    