import xml.etree.ElementTree as ET
from datetime import datetime

def xml_file_parsing(filepath):
    try: 
        root = ET.parse(filepath).getroot()
    except Exception as e:
        print(f"Error parsing through {filepath}: {e}")
        return None
    return root

def extract_shipment_receipt_data(filepath):
        
    root = xml_file_parsing(filepath)
    
    if root is None:  
        return None
    
    header = root.find("Header")
    if header is None:
        print("There is no Header in Receipt")
        return None

    shipment_receipt_data = {
    'po_number': header.find("PONumber").text,
    'shipment_date': datetime.strptime(header.find("ShipmentDate").text, "%Y-%m-%d").strftime("%Y-%m-%d %H:%M:%S"),
    'expected_date': datetime.strptime(header.find("ExpectedDeliveryDate").text, "%Y-%m-%d").strftime("%Y-%m-%d %H:%M:%S"),
    'supplier_name': header.find("Supplier").find("Name").text,
    'carrier': header.find("Carrier").find("Name").text,
    'tracking_number': header.find("Carrier").find("TrackingNumber").text,
    'total_pallets': header.find("TotalPallets").text,
    'notes': header.find("SpecialInstructions").text
    }
    
    
    
    shipment_receipt_items_data = []
    
    lineitems = root.find("LineItems")
    if lineitems is None:
        print("There are no Items in this receipt")
        return None

    shipment_receipt_items_data = []

    for item in lineitems.findall("LineItems"):
        shipment_receipt_items_data.append
        ({
        'fk_product': item.find("SKU").text,
        'quantity_expected': int(item.find("QuantityOrdered").text),
        'quantity_shipped':  int(item.find("QuantityShipped").text),
        'pallets_expected':  int(item.find("PalletsShipped").text),
        'pallets_received':  int(item.find("PalletsShipped").text),
        'notes': item.find("Notes").text
        })




    shipment_receipt_data["shipment_items"] = shipment_receipt_items_data

    return shipment_receipt_data
    