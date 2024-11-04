import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:electric/models/product.dart';
import 'package:electric/models/sale.dart';

class SalesService {
  Database? _db;

  // Initialize the database
  Future<void> initDB() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'electronics_pos.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            sku TEXT,
            price REAL,
            stock INTEGER,
            category TEXT,
            barcode TEXT
            paymentMethod TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE sales(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            items TEXT,
            totalAmount REAL,
            saleDate TEXT
          );
        ''');
      },
      version: 1,
    );
  }

  // Database getter
  Future<Database> get database async {
    if (_db != null) return _db!;
    await initDB();
    return _db!;
  }

  get sales => null;

  // Product Methods
  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Product> getProductById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    } else {
      throw Exception('Product with id $id not found');
    }
  }

  Future<void> updateProductStock(int productId, int newStock) async {
    final db = await database;
    await db.update(
      'products',
      {'stock': newStock},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Product>> getLowStockProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'stock <= ?',
      whereArgs: [5],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  // Sales Methods
  Future<void> addSale(Sale sale) async {
    final db = await database;

    // Wrap sale addition and stock updates in a transaction
    await db.transaction((txn) async {
      try {
        // Insert the sale into the database
        await txn.insert(
          'sales',
          sale.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Update stock levels for each item in the sale
        await updateStockAfterSale(txn, sale);
      } catch (e) {
        print('Error adding sale: $e');
        rethrow; // Re-throw the error to allow further handling if needed
      }
    });
  }

  // Update stock after a sale
  Future<void> updateStockAfterSale(DatabaseExecutor txn, Sale sale) async {
    for (var item in sale.items) {
      int productId = item['id'];
      int quantity = item['quantity'];

      try {
        Product product = await getProductById(productId);
        int updatedStock = product.stock - quantity;

        // Ensure stock doesn't go below zero
        updatedStock = updatedStock < 0 ? 0 : updatedStock;

        // Update product stock in the database using the transaction
        await txn.update(
          'products',
          {'stock': updatedStock},
          where: 'id = ?',
          whereArgs: [productId],
        );
      } catch (e) {
        print('Failed to update stock for product ID $productId: $e');
      }
    }
  }

  Future<List<Sale>> getSalesReport(DateTime startDate, DateTime endDate, {String? paymentMethod}) async {
  final db = await database;
  
  // Build query based on the presence of paymentMethod
  String whereClause = 'saleDate >= ? AND saleDate <= ?';
  List<dynamic> whereArgs = [startDate.toIso8601String(), endDate.toIso8601String()];
  
  if (paymentMethod != null) {
    whereClause += ' AND paymentMethod = ?';
    whereArgs.add(paymentMethod);
  }
  
  final List<Map<String, dynamic>> maps = await db.query(
    'sales',
    where: whereClause,
    whereArgs: whereArgs,
  );

  return List.generate(maps.length, (i) => Sale.fromMap(maps[i]));
}



  Future<List<Sale>> getSales() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sales');
    return List.generate(maps.length, (i) => Sale.fromMap(maps[i]));
  }
}
