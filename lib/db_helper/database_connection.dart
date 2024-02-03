import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_xtremebike2');
    var database = await openDatabase(
      path,
      version: 3, // Increment the version after modifying the schema
      onCreate: _createDatabase,
    );
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    print('Database version: $version');

    // Create 'sepeda' table
    String sepedaTableSql = "CREATE TABLE sepeda (id INTEGER PRIMARY KEY, jenis TEXT, brand TEXT, model TEXT, harga TEXT, keterangan TEXT);";
    await database.execute(sepedaTableSql);

    // Create 'sparepart' table
    String sparepartTableSql = "CREATE TABLE sparepart (id INTEGER PRIMARY KEY, jenis TEXT, brand TEXT, model TEXT, harga TEXT, keterangan TEXT);";
    await database.execute(sparepartTableSql);

    // Create 'perlengkapan' table
    String perlengkapanTableSql = "CREATE TABLE perlengkapan (id INTEGER PRIMARY KEY, jenis TEXT, brand TEXT, model TEXT, harga TEXT, keterangan TEXT);";
    await database.execute(perlengkapanTableSql);
  }
}
