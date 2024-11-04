import 'package:flutter/material.dart';
import 'package:electric/models/product.dart';
import 'package:electric/models/sale.dart';
import 'package:electric/services/sale_service.dart';
import 'package:electric/services/product_service.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final List<Map<String, dynamic>> _cart = []; // Store products added to cart
  double _totalPrice = 0.0;
  double _cartDiscount = 0.0; // Cart discount percentage
  String _selectedPaymentMethod = 'Cash'; // Default payment method

  // Add product to the cart with quantity and discount
  void _addToCart(Product product, int quantity) {
    setState(() {
      _cart.add({
        'product': product,
        'quantity': quantity,
        'discount': 0.0, // Initial discount set to 0%
      });
      _calculateTotal();
    });
  }

  // Calculate total price with item discounts and cart discount
  void _calculateTotal() {
    double itemTotal = _cart.fold(0.0, (sum, item) {
      final product = item['product'];
      final quantity = item['quantity'];
      final discount = item['discount'];
      final discountedPrice = product.price * quantity * ((100 - discount) / 100);
      return sum + discountedPrice;
    });

    // Apply cart discount
    _totalPrice = itemTotal * ((100 - _cartDiscount) / 100);
  }

  // Process the sale
  void _processSale() async {
    Sale sale = Sale(
      id: null, // Setting id as null to be auto-generated by database
      items: _cart,
      totalAmount: _totalPrice,
      saleDate: DateTime.now(),
      paymentMethod: _selectedPaymentMethod,
    );

    await SalesService().addSale(sale);

    // Update product stock after sale
    for (var item in _cart) {
      Product product = item['product'];
      int quantity = item['quantity'];
      product.stock -= quantity;
      await ProductService().updateProduct(product);
    }

    setState(() {
      _cart.clear();
      _totalPrice = 0.0;
      _cartDiscount = 0.0; // Reset cart discount
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Sale processed successfully!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      body: Column(
        children: [
          // Cart discount field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Cart Discount: '),
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(suffixText: '%'),
                    onChanged: (value) {
                      setState(() {
                        _cartDiscount = double.tryParse(value) ?? 0.0;
                        _calculateTotal();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (context, index) {
                final item = _cart[index];
                final product = item['product'];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${item['quantity']}'),
                      Text('Price: \$${product.price * item['quantity']}'),
                      Row(
                        children: [
                          const Text('Discount: '),
                          SizedBox(
                            width: 60,
                            child: TextFormField(
                              initialValue: item['discount'].toString(),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(suffixText: '%'),
                              onChanged: (value) {
                                setState(() {
                                  item['discount'] = double.tryParse(value) ?? 0.0;
                                  _calculateTotal();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total Price: \$$_totalPrice'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedPaymentMethod,
              items: <String>['Cash', 'Credit Card', 'Online']
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              hint: const Text('Select Payment Method'),
            ),
          ),
          ElevatedButton(
            onPressed: _processSale,
            child: const Text('Complete Sale'),
          ),
        ],
      ),
    );
  }
}