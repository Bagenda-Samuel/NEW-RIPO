import 'package:flutter/material.dart';
import 'package:electric/screens/product_list_screen.dart';
import 'package:electric/screens/sales_screen.dart';
import 'package:electric/screens/sales_report_screen.dart';
import 'package:electric/screens/customer_list_screen.dart';
import 'package:electric/screens/customer_form_screen.dart';
import 'package:electric/screens/low_stock_screen.dart';

void main() {
  runApp(const ElectricApp());
}

class ElectricApp extends StatelessWidget {
  const ElectricApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electric Store Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/product-list': (context) => const ProductListScreen(),
        '/sales': (context) => const SalesScreen(),
        '/sales-report': (context) => const SalesReportScreen(),
        '/customer-list': (context) => const CustomerListScreen(),
        '/customer-form': (context) => const CustomerFormScreen(),
        '/low-stock': (context) => const LowStockScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electric Store Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/product-list');
              },
              child: const Text('Manage Products'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sales');
              },
              child: const Text('Sales'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sales-report');
              },
              child: const Text('Sales Report'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customer-list');
              },
              child: const Text('Customers'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/low-stock');
              },
              child: const Text('Low Stock Alert'),
            ),
          ],
        ),
      ),
    );
  }
}
