import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:electric/models/product.dart';

class ProductService {
  Database? _db;

  // Initialize the database
  Future<void> initDB() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'electronics_pos.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            sku TEXT,
            price REAL,
            stock INTEGER,
            category TEXT,
            barcode TEXT
          )
          ''',
        );
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

  // Add a new product to the inventory
  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update product details in the inventory
  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Delete a product from the inventory
  Future<void> deleteProduct(int id) async {
    final db = await database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fetch a specific product by ID
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
      throw Exception('Product not found');
    }
  }

  // Fetch products with low or zero stock
  Future<List<Product>> getLowStockProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'stock <= ?',
      whereArgs: [5],  // Set your low stock threshold here
    );

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  // Fetch products with zero stock
  Future<List<Product>> getZeroStockProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'stock = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  // Fetch all products
Future<List<Product>> getProducts() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('products');

  return List.generate(maps.length, (i) {
    return Product.fromMap(maps[i]);
  });
}

}
