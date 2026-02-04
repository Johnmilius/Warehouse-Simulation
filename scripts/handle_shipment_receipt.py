import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))
from utils.xml_utils import extract_shipment_receipt_data 

import os
import shutil
from datetime import datetime 
from natsort import natsorted


def process_reciept():
    # Get project root (parent of services folder)
    project_root = Path(__file__).parent.parent

    pending_dir = project_root / "shipment_receipts" / "pending_shipment_receipts"
    processed_dir = project_root / "shipment_receipts" / "processed_shipment_receipts"
    
    
    xml_files = list(pending_dir.glob("*.xml"))
    
    # if no reciepts return
    if not xml_files:
        print("No Receipts to Process")
        return

    xml_files_sorted = natsorted(xml_files)
        
    # Debug for sorted list
    # for file in xml_files_sorted:
    #     print(f"Receipt File Name: {file.name}")
    
    try:
        full_file_path = xml_files_sorted[0]
        
        receipt_data = extract_shipment_receipt_data(full_file_path)
        
        print()
        print(f"RECEIPT\n{receipt_data}\n")
        print()
        
        # move file to processed folder
        shutil.move(full_file_path, processed_dir / full_file_path.name) 
        
        return receipt_data   

    except Exception as e:
        print(f"Error when parsing data from {full_file_path}: {e}")
    
   




    # handle all files
    # for i, file in enumerate(xml_files_sorted):
    #     try:
    #         full_file_path = str(file)
            
    #         receipt_data = extract_shipment_receipt_data(full_file_path)
            
    #         print(f"RECEIPT {i}\n{receipt_data}\n")
    #         # shutil.move(str(file), str(processed_dir / file.name))    

    #     except Exception as e:
    #         print(f"Error when parsing data from {full_file_path}: {e}")   
    #once process move receipt to the file to the processed receipts.
    # shutil.move(str(file), str(processed_dir / file.name))    
