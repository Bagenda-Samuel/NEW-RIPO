import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/customer_list_screen.dart';
import 'screens/customer_form_screen.dart';
import 'screens/inventory_report_screen.dart';
import 'screens/low_stock_screen.dart';
import 'screens/product_form_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/receipt_screen.dart';
import 'screens/sales_report_screen.dart';
import 'screens/sales_screen.dart';  // Import SalesScreen
import 'models/sale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set HomeScreen as the initial route
      onGenerateRoute: (settings) {
        if (settings.name == '/receipt') {
          final Sale sale = settings.arguments as Sale;
          return MaterialPageRoute(
            builder: (context) {
              return ReceiptScreen(sale: sale);
            },
          );
        }

        // Define routes for other screens
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case '/customerList':
            return MaterialPageRoute(builder: (context) => const CustomerListScreen());
          case '/customerForm':
            return MaterialPageRoute(builder: (context) => const CustomerFormScreen());
          case '/inventoryReport':
            return MaterialPageRoute(builder: (context) => const InventoryReportScreen());
          case '/lowStock':
            return MaterialPageRoute(builder: (context) => const LowStockScreen());
          case '/productForm':
            return MaterialPageRoute(builder: (context) => const ProductFormScreen());
          case '/productList':
            return MaterialPageRoute(builder: (context) => const ProductListScreen());
          case '/salesReport':
            return MaterialPageRoute(builder: (context) => const SalesReportScreen());
          case '/salesScreen':  // Add route for SalesScreen
            return MaterialPageRoute(builder: (context) => const SalesScreen());
          default:
            return null;
        }
      },
    );
  }
}
