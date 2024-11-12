import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS System Home'),
      ),
      body: Column(
        children: [
          // Horizontal scrollable navigation buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                // Customer dropdown button
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    switch (result) {
                      case 'Customer Master':
                        Navigator.pushNamed(context, '/customerForm');
                        break;
                      case 'Customer List':
                        Navigator.pushNamed(context, '/customerList');
                        break;
                      case 'Customer History':
                        Navigator.pushNamed(context, '/customerHistory');
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Customer Master',
                      child: Text('Customer Master'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Customer List',
                      child: Text('Customer List'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Customer History',
                      child: Text('Customer History'),
                    ),
                  ],
                  child: const ElevatedButton(
                    onPressed: null,
                    child: Text('Customer'),
                  ),
                ),
                const SizedBox(width: 8),

                // Sales dropdown button with updated navigation
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    switch (result) {
                      case 'Sales Bill':
                        Navigator.pushNamed(context, '/salesScreen'); // Leads to sales_screen.dart
                        break;
                      case 'Sales Invoice':
                        Navigator.pushNamed(context, '/salesInvoice');
                        break;
                      case 'Sales Order':
                        Navigator.pushNamed(context, '/salesOrder');
                        break;
                      case 'Delivery Note':
                        Navigator.pushNamed(context, '/deliveryNote');
                        break;
                      case 'Sales Return':
                        Navigator.pushNamed(context, '/salesReturn');
                        break;
                      case 'Sales Report':
                        Navigator.pushNamed(context, '/salesReportScreen'); // Leads to sales_report_screen.dart
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Sales Bill',
                      child: Text('Sales Bill'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Sales Invoice',
                      child: Text('Sales Invoice'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Sales Order',
                      child: Text('Sales Order'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delivery Note',
                      child: Text('Delivery Note'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Sales Return',
                      child: Text('Sales Return'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Sales Report',
                      child: Text('Sales Report'),
                    ),
                  ],
                  child: const ElevatedButton(
                    onPressed: null,
                    child: Text('Sales'),
                  ),
                ),
                const SizedBox(width: 8),

                // Purchases dropdown button
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    switch (result) {
                      case 'Purchase Master':
                        Navigator.pushNamed(context, '/purchaseMaster');
                        break;
                      case 'Purchase Invoice':
                        Navigator.pushNamed(context, '/purchaseInvoice');
                        break;
                      case 'Purchase Order':
                        Navigator.pushNamed(context, '/purchaseOrder');
                        break;
                      case 'Goods Received Note':
                        Navigator.pushNamed(context, '/goodsReceivedNote');
                        break;
                      case 'Purchase Return':
                        Navigator.pushNamed(context, '/purchaseReturn');
                        break;
                      case 'Purchase Credit Note':
                        Navigator.pushNamed(context, '/purchaseCreditNote');
                        break;
                      case 'Stock Transfer':
                        Navigator.pushNamed(context, '/stockTransfer');
                        break;
                      case 'Supplier Payments':
                        Navigator.pushNamed(context, '/supplierPayments');
                        break;
                      case 'Purchase Report':
                        Navigator.pushNamed(context, '/purchaseReport');
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Purchase Master',
                      child: Text('Purchase Master'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Purchase Invoice',
                      child: Text('Purchase Invoice'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Purchase Order',
                      child: Text('Purchase Order'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Goods Received Note',
                      child: Text('Goods Received Note'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Purchase Return',
                      child: Text('Purchase Return'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Purchase Credit Note',
                      child: Text('Purchase Credit Note'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Stock Transfer',
                      child: Text('Stock Transfer'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Supplier Payments',
                      child: Text('Supplier Payments'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Purchase Report',
                      child: Text('Purchase Report'),
                    ),
                  ],
                  child: const ElevatedButton(
                    onPressed: null,
                    child: Text('Purchases'),
                  ),
                ),
                const SizedBox(width: 8),

                // Other buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/inventoryReport');
                  },
                  child: const Text('Inventory'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/tools');
                  },
                  child: const Text('Tools'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reports');
                  },
                  child: const Text('Reports'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
          // Additional content below the horizontal navigation
          const Expanded(
            child: Center(
              child: Text('# B S M #'),
            ),
          ),
        ],
      ),
    );
  }
}
