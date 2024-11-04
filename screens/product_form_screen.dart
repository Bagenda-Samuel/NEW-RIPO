import 'package:flutter/material.dart';
import 'package:electric/models/product.dart';
import 'package:electric/services/product_service.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product; // Use this for editing

  const ProductFormScreen({super.key, this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _sku = '';
  double _price = 0;
  int _stock = 0;
  String _category = '';
  String _barcode = '';

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!.name;
      _sku = widget.product!.sku;
      _price = widget.product!.price;
      _stock = widget.product!.stock;
      _category = widget.product!.category;
      _barcode = widget.product!.barcode;
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Product newProduct = Product(
        id: widget.product?.id,
        name: _name,
        sku: _sku,
        price: _price,
        stock: _stock,
        category: _category,
        barcode: _barcode,
      );

      try {
        if (widget.product == null) {
          await ProductService().addProduct(newProduct);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added successfully')),
          );
        } else {
          await ProductService().updateProduct(newProduct);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product updated successfully')),
          );
        }
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save product: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Product Name'),
                onSaved: (value) => _name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a product name' : null,
              ),
              TextFormField(
                initialValue: _sku,
                decoration: const InputDecoration(labelText: 'SKU'),
                onSaved: (value) => _sku = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                initialValue: _stock.toString(),
                decoration: const InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _stock = int.parse(value!),
              ),
              TextFormField(
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value!,
              ),
              TextFormField(
                initialValue: _barcode,
                decoration: const InputDecoration(labelText: 'Barcode'),
                onSaved: (value) => _barcode = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text(widget.product == null ? 'Add Product' : 'Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
