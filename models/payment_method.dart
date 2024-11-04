class PaymentMethod {
  final String id;
  final String name;

  PaymentMethod({
    required this.id,
    required this.name,
  });

  // Convert a PaymentMethod instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create a PaymentMethod instance from a Map
  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
    );
  }
}
