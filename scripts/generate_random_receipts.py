## AI GENERATED FILE ##

import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))

import random
from datetime import datetime, timedelta
from xml.etree.ElementTree import Element, SubElement, tostring
from xml.dom import minidom

# All 19 Lola Blanket types with their product codes
BLANKET_TYPES = [
    (1001, "Caramel N' Cream"),
    (1002, "Antique Ivory"),
    (1003, "Creamy Cloud"),
    (1004, "Desert Dune"),
    (1005, "Smoky Skies"),
    (1006, "Blush Pink"),
    (1007, "Malibu Blue"),
    (1008, "Midnight Marie"),
    (1009, "Rainy Day"),
    (1010, "Rosewater"),
    (1011, "Chillin' Cheetah"),
    (1012, "Latte Check"),
    (1013, "Mocha Check"),
    (1014, "Toasted Almond"),
    (1015, "Peaches & Cream"),
    (1016, "Huckleberry Harvest"),
    (1017, "Silver Linings"),
    (1018, "Navy Blue"),
    (1019, "Charcoal Grey")
]

# Size configurations: (size_code, size_name, blankets_per_pallet, boxes_per_pallet)
SIZES = [
    ('01', 'Baby', 180, 18),
    ('02', 'Medium', 72, 18),
    ('03', 'Large', 48, 12),
    ('04', 'Extra Large', 24, 8)
]

CARRIERS = [
    "XYZ Freight Lines",
    "FedEx Freight",
    "UPS Freight",
    "Old Dominion",
    "R+L Carriers",
    "Estes Express"
]

SPECIAL_INSTRUCTIONS = [
    "Deliver to Dock 3. Fragile - Handle with care.",
    "Call 30 minutes before arrival.",
    "Appointment required for delivery.",
    "Deliver to receiving area. No appointment needed.",
    "Inside delivery required.",
    "Tailgate delivery.",
    "Check with warehouse manager upon arrival."
]


def generate_sku(product_code, size_code):
    """Generate SKU in format: 302-XXXX-XX"""
    return f"302-{product_code:04d}-{size_code}"


def generate_product_description(blanket_name, size_name):
    """Generate product description"""
    return f"Lola {blanket_name} - {size_name}"


def generate_random_date_range():
    """Generate realistic shipment and delivery dates"""
    # Shipment date: random date within last 30 days or next 7 days
    days_offset = random.randint(-30, 7)
    shipment_date = datetime.now() + timedelta(days=days_offset)
    
    # Delivery date: 2-7 days after shipment
    transit_days = random.randint(2, 7)
    delivery_date = shipment_date + timedelta(days=transit_days)
    
    return shipment_date.strftime('%Y-%m-%d'), delivery_date.strftime('%Y-%m-%d')


def generate_line_items(num_items):
    """Generate random line items for the receipt"""
    line_items = []
    total_pallets = 0
    
    # Randomly select products (could be duplicates or not)
    available_products = []
    for product_code, blanket_name in BLANKET_TYPES:
        for size_code, size_name, blankets_per_pallet, boxes_per_pallet in SIZES:
            available_products.append({
                'product_code': product_code,
                'blanket_name': blanket_name,
                'size_code': size_code,
                'size_name': size_name,
                'blankets_per_pallet': blankets_per_pallet,
                'boxes_per_pallet': boxes_per_pallet
            })
    
    selected_products = random.sample(available_products, min(num_items, len(available_products)))
    
    for i, product in enumerate(selected_products, 1):
        # Random number of pallets (1-5 typically)
        pallets = random.randint(1, 5)
        
        # Calculate quantity based on pallets
        quantity = pallets * product['blankets_per_pallet']
        
        sku = generate_sku(product['product_code'], product['size_code'])
        description = generate_product_description(product['blanket_name'], product['size_name'])
        
        line_item = {
            'line_number': i,
            'sku': sku,
            'description': description,
            'quantity_ordered': quantity,
            'quantity_shipped': quantity,  # Could be different in real scenarios
            'pallets': pallets,
            'blankets_per_pallet': product['blankets_per_pallet'],
            'boxes_per_pallet': product['boxes_per_pallet'],
            'notes': f"{pallets} pallet{'s' if pallets > 1 else ''}, {pallets * product['boxes_per_pallet']} boxes"
        }
        
        line_items.append(line_item)
        total_pallets += pallets
    
    return line_items, total_pallets


def create_xml_receipt(po_number, num_line_items=None):
    """Create a complete XML receipt"""
    
    # Random number of line items if not specified (1-5)
    if num_line_items is None:
        num_line_items = random.randint(1, 5)
    
    # Generate dates
    shipment_date, delivery_date = generate_random_date_range()
    
    # Generate line items
    line_items, total_pallets = generate_line_items(num_line_items)
    
    # Calculate total quantities
    total_quantity = sum(item['quantity_shipped'] for item in line_items)
    
    # Calculate approximate weight (rough estimate: ~5 lbs per blanket)
    total_weight = total_quantity * 5
    
    # Create XML structure
    root = Element('AdvanceShipNotice')
    
    # Header
    header = SubElement(root, 'Header')
    SubElement(header, 'PONumber').text = po_number
    SubElement(header, 'ShipmentDate').text = shipment_date
    SubElement(header, 'ExpectedDeliveryDate').text = delivery_date
    
    # Supplier
    supplier = SubElement(header, 'Supplier')
    SubElement(supplier, 'Name').text = 'Lola Blankets Manufacturing'
    SubElement(supplier, 'ContactEmail').text = 'shipping@lolablankets.com'
    SubElement(supplier, 'ContactPhone').text = '555-0100'
    
    # Carrier
    carrier = SubElement(header, 'Carrier')
    carrier_name = random.choice(CARRIERS)
    SubElement(carrier, 'Name').text = carrier_name
    
    # Generate tracking number
    tracking_prefix = ''.join(random.choices('ABCDEFGHIJKLMNOPQRSTUVWXYZ', k=3))
    tracking_number = f"TRK-{datetime.now().year}-{tracking_prefix}{random.randint(100, 999)}"
    SubElement(carrier, 'TrackingNumber').text = tracking_number
    
    # BOL Number
    bol_number = f"BOL-{random.randint(100000, 999999)}"
    SubElement(carrier, 'BOLNumber').text = bol_number
    
    # Header totals
    SubElement(header, 'TotalPallets').text = str(total_pallets)
    weight = SubElement(header, 'TotalWeight')
    weight.set('unit', 'lbs')
    weight.text = str(total_weight)
    
    SubElement(header, 'SpecialInstructions').text = random.choice(SPECIAL_INSTRUCTIONS)
    
    # Line Items
    line_items_element = SubElement(root, 'LineItems')
    
    for item in line_items:
        line_item = SubElement(line_items_element, 'LineItem')
        SubElement(line_item, 'LineNumber').text = str(item['line_number'])
        SubElement(line_item, 'SKU').text = item['sku']
        SubElement(line_item, 'ProductDescription').text = item['description']
        SubElement(line_item, 'QuantityOrdered').text = str(item['quantity_ordered'])
        SubElement(line_item, 'QuantityShipped').text = str(item['quantity_shipped'])
        SubElement(line_item, 'UnitOfMeasure').text = 'blankets'
        SubElement(line_item, 'PalletsShipped').text = str(item['pallets'])
        SubElement(line_item, 'BlanketPerPallet').text = str(item['blankets_per_pallet'])
        SubElement(line_item, 'Notes').text = item['notes']
    
    # Summary
    summary = SubElement(root, 'Summary')
    SubElement(summary, 'TotalLines').text = str(len(line_items))
    SubElement(summary, 'TotalQuantity').text = str(total_quantity)
    SubElement(summary, 'TotalPallets').text = str(total_pallets)
    
    return root


def prettify_xml(elem):
    """Return a pretty-printed XML string"""
    rough_string = tostring(elem, encoding='utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="  ", encoding='UTF-8').decode('utf-8')


def generate_receipts(count=1, output_dir=None):
    """Generate multiple random receipts"""
    
    if output_dir is None:
        # Default to pending_shipment_receipts folder
        project_root = Path(__file__).parent.parent
        output_dir = project_root / "shipment_receipts" / "pending_shipment_receipts"
    else:
        output_dir = Path(output_dir)
    
    # Create directory if it doesn't exist
    output_dir.mkdir(parents=True, exist_ok=True)
    
    generated_files = []
    
    for i in range(count):
        # Generate PO number
        year = datetime.now().year
        po_num = random.randint(1, 999)
        po_number = f"PO-{year}-{po_num:03d}"
        
        # Create XML
        xml_root = create_xml_receipt(po_number)
        
        # Save to file
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        filename = f"receipt_{timestamp}_{i+1}.xml"
        filepath = output_dir / filename
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(prettify_xml(xml_root))
        
        generated_files.append(filepath)
        print(f"Generated: {filename}")
    
    return generated_files


if __name__ == "__main__":
    # Generate receipts based on command line argument
    import argparse
    
    parser = argparse.ArgumentParser(description='Generate random Lola Blankets shipment receipts')
    parser.add_argument('-n', '--number', type=int, default=1, 
                       help='Number of receipts to generate (default: 1)')
    parser.add_argument('-o', '--output', type=str, default=None,
                       help='Output directory (default: shipment_receipts/pending_shipment_receipts)')
    
    args = parser.parse_args()
    
    print(f"\n🎲 Generating {args.number} random shipment receipt(s)...\n")
    files = generate_receipts(count=args.number, output_dir=args.output)
    print(f"\n✅ Successfully generated {len(files)} receipt(s)!")
