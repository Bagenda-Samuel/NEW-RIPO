class Sale {
  final int? id;
  final DateTime saleDate;
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final String paymentMethod; // Add this line

  Sale({
    required this.id,
    required this.saleDate,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod, // Add this line
  });

  // Modify the fromMap and toMap methods to include paymentMethod
  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'],
      saleDate: DateTime.parse(map['saleDate']),
      items: List<Map<String, dynamic>>.from(map['items']),
      totalAmount: map['totalAmount'],
      paymentMethod: map['paymentMethod'], // Add this line
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saleDate': saleDate.toIso8601String(),
      'items': items,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod, // Add this line
    };
  }
}
