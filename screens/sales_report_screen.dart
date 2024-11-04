import 'package:flutter/material.dart';
import 'package:electric/models/sale.dart';
import 'package:electric/services/sale_service.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  List<Sale> _sales = [];
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String? _selectedPaymentMethod;
  bool _isLoading = false;

  // Fetch sales report within the date range
  Future<void> _fetchSalesReport() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final sales = await SalesService().getSalesReport(
        _startDate,
        _endDate,
        paymentMethod: _selectedPaymentMethod == 'All' ? null : _selectedPaymentMethod,
      );
      setState(() {
        _sales = sales;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching sales report: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );
    if (picked != null && picked.start != _startDate && picked.end != _endDate) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _fetchSalesReport();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSalesReport(); // Fetch sales when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
      ),
      body: Column(
        children: [
          // Date Range and Payment Method Filter
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('From: ${_startDate.toLocal()}'.split(' ')[0]),
                Text('To: ${_endDate.toLocal()}'.split(' ')[0]),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDateRange(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: _selectedPaymentMethod,
              hint: const Text('Select Payment Method'),
              items: <String>['All', 'Cash', 'Credit Card', 'Online']
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
                _fetchSalesReport();
              },
            ),
          ),
          // Sales List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _sales.length,
                    itemBuilder: (context, index) {
                      final sale = _sales[index];
                      return ListTile(
                        title: Text('Sale ID: ${sale.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Amount: \$${sale.totalAmount}'),
                            Text('Sale Date: ${sale.saleDate.toLocal()}'),
                            Text('Items Sold: ${sale.items.length}'),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          // Generate Report Button
          ElevatedButton(
            onPressed: _fetchSalesReport,
            child: const Text('Generate Report'),
          ),
        ],
      ),
    );
  }
}
