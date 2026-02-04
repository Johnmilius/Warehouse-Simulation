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

    # debug statement
    print()
    print(f"Parsing Receipt: {filepath}")
    print()
    
    # Grab shipment data
    shipment_receipt_data = {
    'po_number': header.find("PONumber").text,
    'shipment_date': datetime.strptime(header.find("ShipmentDate").text, "%Y-%m-%d"),
    'expected_date': datetime.strptime(header.find("ExpectedDeliveryDate").text, "%Y-%m-%d"),
    'supplier_name': header.find("Supplier/Name").text,
    'carrier': header.find("Carrier/Name").text,
    'tracking_number': header.find("Carrier/TrackingNumber").text,
    'total_pallets': int(header.find("TotalPallets").text),
    'notes': header.find("SpecialInstructions").text
    }
    
    shipment_receipt_items_data = []
    
    lineitems = root.find("LineItems")
    if lineitems is None:
        print("There are no Items in this receipt")
        return None

    # debug lineitems
    # print(lineitems)
    
    # Grab Data for items
    for item in lineitems.findall("LineItem"):
        item_data = {
        'sku': item.find("SKU").text,
        'quantity_expected': int(item.find("QuantityOrdered").text),
        'quantity_received': int(item.find("QuantityShipped").text), # !!! FALSE DATA JUST TEMPORARY HARD CODE
        'quantity_shipped':  int(item.find("QuantityShipped").text),
        'pallets_expected':  int(item.find("PalletsShipped").text),
        'pallets_received':  int(item.find("PalletsShipped").text),
        'notes': item.find("Notes").text
        }
        
        shipment_receipt_items_data.append(item_data)
        #debug
        print(f"Found {item_data} Item")



    # add items to the reciept
    shipment_receipt_data["shipment_items"] = shipment_receipt_items_data

    # Debug: Print complete shipment receipt data
    print()
    print("Parsed Receipt With Data")
    print()
    print("=== SHIPMENT RECEIPT DATA ===")
    for key, value in shipment_receipt_data.items():
        if key != "shipment_items":
            print(f"{key}: {value}")
    print(f"Total Items: {len(shipment_receipt_data['shipment_items'])}")
    
    items = shipment_receipt_data["shipment_items"]
    print(f"Total Items: {len(items)}")
    print("=" * 30 + "\n")

    for i, item in enumerate(items, start=1):
        print(f"Item #{i}")
        for field, val in item.items():
            print(f"  {field}: {val}")
        print("-" * 20)
    return shipment_receipt_data
    