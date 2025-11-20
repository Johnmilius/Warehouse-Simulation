BLANKET_TYPES = {
    "1001": "Caramel N' Cream",
    "1002": "Antique Ivory",
    "1003": "Creamy Cloud",
    "1004": "Desert Dune",
    "1005": "Smoky Skies",
    "1006": "Blush Pink",
    "1007": "Malibu Blue",
    "1008": "Midnight Marie",
    "1009": "Rainy Day",
    "1010": "Rosewater",
    "1011": "Chillin' Cheetah",
    "1012": "Latte Check",
    "1013": "Mocha Check",
    "1014": "Toasted Almond",
    "1015": "Peaches & Cream",
    "1016": "Huckleberry Harvest",
    "1017": "Silver Linings",
    "1018": "Navy Blue",
    "1019": "Charcoal Grey"
}

SIZES = {
    # sku: {name: str, blankets_per_pallet: int, boxes_per_pallet: int, box_configuration: str, blankets_per_box: int, cost: int, price: int}
    "01": {
        'name': 'Baby',
        'blankets_per_pallet': 180,
        'boxes_per_pallet': 18,
        'box_configuration': '2 X 3 X 3', # This indicates the stacking pattern on the pallet
        'blankets_per_box': 10, # Calculated: 180 / 18
        'price': 109,
        'cost': 50
    },
    "02": {
        'name': 'Medium',
        'blankets_per_pallet': 72,
        'boxes_per_pallet': 18,
        'box_configuration': '2 X 3 X 3',
        'blankets_per_box': 4, # Calculated: 72 / 18
        'price': 249,
        'cost': 50
    },
    "03": {
        'name': 'Large',
        'blankets_per_pallet': 48,
        'boxes_per_pallet': 12,
        'box_configuration': '2 X 2 X 3',
        'blankets_per_box': 4, # Calculated: 48 / 12
        'price': 299,
        'cost': 50
    },
    "04": {
        'name': 'Extra Large',
        'blankets_per_pallet': 32,
        'boxes_per_pallet': 16,
        'box_configuration': '2 X 4 X 2',
        'blankets_per_box': 2, # Calculated: 32 / 16
        'price': 399,
        'cost': 50
    },
    "05": {
        'name': 'Pet Bed Small',
        'blankets_per_pallet': None, # Placeholder for missing data
        'boxes_per_pallet': None,
        'box_configuration': None,
        'blankets_per_box': None
    },
    "06": {
        'name': 'Pet Bed Large',
        'blankets_per_pallet': None,
        'boxes_per_pallet': None,
        'box_configuration': None,
        'blankets_per_box': None
    },
    "07": {
        'name': 'Pet Pad',
        'blankets_per_pallet': None,
        'boxes_per_pallet': None,
        'box_configuration': None,
        'blankets_per_box': None
    }
}

BUSINESS_CODES = {
    "302": 'Lola'
}

WAREHOUSE_CONFIG = {
    'TOTAL_NUMBER_LOCATIONS_WAREHOUSE_1': 4896,
    'TOTAL_NUMBER_LOCATIONS_WAREHOUSE_2': 70,
    'TARGET_FILL_PERCENTAGE': .75
}
