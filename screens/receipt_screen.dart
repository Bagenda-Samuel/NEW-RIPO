import 'package:flutter/material.dart';
import 'package:electric/models/sale.dart';

class ReceiptScreen extends StatelessWidget {
  final Sale sale;

  const ReceiptScreen({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Receipt ID: ${sale.id}', style: const TextStyle(fontSize: 20)),
            Text('Date: ${sale.saleDate}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Items Sold:', style: TextStyle(fontSize: 18)),
            ...sale.items.map((item) {
              final product = item['product'];
              final quantity = item['quantity'];
              return Text('${product.name} - $quantity x \$${product.price}');
            }).toList(),
            const SizedBox(height: 20),
            Text('Total Amount: \$${sale.totalAmount}', style: const TextStyle(fontSize: 20)),
            Text('Payment Method: ${sale.paymentMethod}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
