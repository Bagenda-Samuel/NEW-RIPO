import 'package:flutter/material.dart';
import 'screens/customer_list_screen.dart';
import 'screens/customer_form_screen.dart';
import 'screens/inventory_report_screen.dart';
import 'screens/low_stock_screen.dart';
import 'screens/product_form_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/receipt_screen.dart';
import 'screens/sales_report_screen.dart';
import 'models/sale.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/receipt') {
          final Sale sale = settings.arguments as Sale;
          return MaterialPageRoute(
            builder: (context) {
              return ReceiptScreen(sale: sale);
            },
          );
        }
        // Add other routes with specific arguments if needed
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => CustomerListScreen());
          case '/customerForm':
            return MaterialPageRoute(builder: (context) => CustomerFormScreen());
          case '/inventoryReport':
            return MaterialPageRoute(builder: (context) => InventoryReportScreen());
          case '/lowStock':
            return MaterialPageRoute(builder: (context) => LowStockScreen());
          case '/productForm':
            return MaterialPageRoute(builder: (context) => ProductFormScreen());
          case '/productList':
            return MaterialPageRoute(builder: (context) => ProductListScreen());
          case '/salesReport':
            return MaterialPageRoute(builder: (context) => SalesReportScreen());
          default:
            return null;
        }
      },
    );
  }
}
