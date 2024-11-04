import 'package:flutter/material.dart';
import 'package:electric/models/product.dart';
import 'package:electric/services/product_service.dart';

class LowStockScreen extends StatefulWidget {
  const LowStockScreen({super.key});

  @override
  _LowStockScreenState createState() => _LowStockScreenState();
}

class _LowStockScreenState extends State<LowStockScreen> {
  List<Product> _lowStockProducts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLowStockProducts();
  }

  // Load low stock products from the database
  void _loadLowStockProducts() async {
    try {
      List<Product> products = await ProductService().getLowStockProducts();
      setState(() {
        _lowStockProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load low stock products';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Low Stock Products'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _lowStockProducts.isEmpty
                  ? const Center(child: Text('No low stock products!'))
                  : ListView.builder(
                      itemCount: _lowStockProducts.length,
                      itemBuilder: (context, index) {
                        Product product = _lowStockProducts[index];
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
