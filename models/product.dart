class Product {
  final int? id;
  final String name;
  final String sku;
  final double price;
  late final int stock;
  final String category;
  final String barcode;

  Product({
    this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.stock,
    required this.category,
    required this.barcode,
  });

  // Convert a Product object into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'price': price,
      'stock': stock,
      'category': category,
      'barcode': barcode,
    };
  }

  // Extract a Product object from a Map.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      price: map['price'],
      stock: map['stock'],
      category: map['category'],
      barcode: map['barcode'],
    );
  }
}
