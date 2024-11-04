class Customer {
  final int id; // Change from String to int
  final String name;
  final String email;
  final String phone;
  final String address;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  // Convert a Customer object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  // Create a Customer object from a map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int, // Make sure to cast it as int
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
    );
  }
}
