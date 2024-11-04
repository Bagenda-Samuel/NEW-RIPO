class Item {
  final int id; // Assuming each item has a unique ID
  final String name; // Name of the product
  final int quantity; // Quantity sold
  final double price; // Price of the product

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  // Convert Item object to map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  // Convert map from database to Item object
  static Item fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}
