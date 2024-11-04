// services/customer_service.dart
import 'package:electric/models/customer.dart';

class CustomerService {
  final List<Customer> _customers = [];

  Future<List<Customer>> getAllCustomers() async => _customers; // Ensure this returns a List<Customer>

 Customer? getCustomerById(int id) {
  try {
    return _customers.firstWhere((customer) => customer.id == id);
  } catch (e) {
    return null;
    }
  }

  
  void addCustomer(Customer customer) {
    _customers.add(customer);
  }

  void updateCustomer(int id, Customer updatedCustomer) {
    final index = _customers.indexWhere((c) => c.id == id);
    if (index != -1) _customers[index] = updatedCustomer;
  }

  void deleteCustomer(int id) {
    _customers.removeWhere((c) => c.id == id);
  }

  
}
