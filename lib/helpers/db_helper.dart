import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:otomedia_crud/models/kontak.dart';

class KontakDbHelper {
  static final KontakDbHelper _instance = KontakDbHelper._internal();

  factory KontakDbHelper() {
    return _instance;
  }

  KontakDbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'kontak.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE kontak(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        no_hp TEXT NOT NULL
      )
    ''');
  }

  // Insert kontak baru
  Future<int> insertKontakbaru(Kontak kontak) async {
    Database db = await database;
    return await db.insert('kontak', kontak.toMap());
  }

  // Fetch semua kontak
  Future<List<Kontak>> fetchAllKontak() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('kontak');

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return Kontak.fromMap(maps[i]);
    });
  }

  // Update kontak
  Future<int> updateKontak(Kontak kontak) async {
    Database db = await database;
    return await db.update(
      'kontak',
      kontak.toMap(),
      where: 'id = ?',
      whereArgs: [kontak.id],
    );
  }

  // Delete kontak
  Future<int> deleteKontak(int id) async {
    Database db = await database;
    return await db.delete(
      'kontak',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}