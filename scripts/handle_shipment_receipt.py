import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))
from utils.xml_file_parsing import extract_shipment_receipt_data 

import os
from pathlib import Path
import shutil
from datetime import datetime 


def process_reciept():
    # Get project root (parent of services folder)
    project_root = Path(__file__).parent.parent

    pending_dir = project_root / "shipment_receipts" / "pending_shipment_receipts"
    processed_dir = project_root / "shipment_receipts" / "processed_shipment_receipts"
    
    
    xml_files = list(pending_dir.glob("*.xml"))
    
    if not xml_files:
        print("No Receipts to Process")
        return
    
    file = xml_files[0]
    
    print(f"Grabbed File {file} to proccess.")
    
    try:
        full_file_path = str(file)
        
        receipt_data = extract_shipment_receipt_data(full_file_path)
        print(receipt_data)
    except Exception as e:
        print(f"Error when parsing data from {full_file_path}: {e}")
        
    
        


process_reciept()