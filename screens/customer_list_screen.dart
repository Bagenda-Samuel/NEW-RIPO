import 'package:flutter/material.dart';
import 'package:electric/models/customer.dart';
import 'package:electric/services/customer_service.dart';
import 'customer_form_screen.dart'; // Import the form screen to navigate to it

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  late CustomerService _customerService;
  List<Customer> _customers = [];

  @override
  void initState() {
    super.initState();
    _customerService = CustomerService();
    _loadCustomers();
  }

  // Load customers from CustomerService
  Future<void> _loadCustomers() async {
    final customers = await _customerService.getAllCustomers();
    setState(() {
      _customers = customers;
    });
  }

  // Delete customer and refresh the list
  void _deleteCustomer(int id) async {
    _customerService.deleteCustomer(id);
    await _loadCustomers();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Customer deleted successfully'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Navigate to add customer form
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CustomerFormScreen()),
              );
              _loadCustomers(); // Reload customers after adding
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _customers.length,
        itemBuilder: (context, index) {
          final customer = _customers[index];
          return ListTile(
            title: Text(customer.name),
            subtitle: Text(customer.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    // Navigate to edit customer form
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerFormScreen(customer: customer),
                      ),
                    );
                    _loadCustomers(); // Reload customers after editing
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteCustomer(customer.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
