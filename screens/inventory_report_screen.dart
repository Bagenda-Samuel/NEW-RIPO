import 'package:flutter/material.dart';
import 'package:electric/services/product_service.dart';
import 'package:electric/models/product.dart';

class InventoryReportScreen extends StatefulWidget {
  const InventoryReportScreen({super.key});

  @override
  _InventoryReportScreenState createState() => _InventoryReportScreenState();
}

class _InventoryReportScreenState extends State<InventoryReportScreen> {
  List<Product> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Fetch the inventory report
  Future<void> _fetchInventoryReport() async {
    try {
      final products = await ProductService().getLowStockProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load inventory report';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchInventoryReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Report'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _products.isEmpty
                  ? const Center(child: Text('No low stock products found.'))
                  : ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('Stock: ${product.stock}'),
                          trailing: product.stock <= 5
                              ? const Icon(Icons.warning, color: Colors.red)
                              : null,
                        );
                      },
                    ),
    );
  }
}
