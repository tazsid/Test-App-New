import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/models/all_data_model.dart';

class DatabaseHelper {
  static const _databaseName = "test_db.db";
  static const _databaseVersion = 1;

  static const tableData = 'data_table';

  //data vars
  static const columnId = 'n_product_uniq_id';
  static const columnStateId = 'n_state_uniq_id';
  static const columnStateName = 'c_state_name';
  static const columnEffectiveFrom = 'effective_from';
  static const columnAddedByAdminId = 'c_added_by_admin_user_id';
  static const columnProductRate = 'product_rate';
  static const columnAddedTime = 'added_time';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableData (
            $columnId INTEGER,
            $columnStateId INTEGER,
            $columnStateName TEXT,
            $columnEffectiveFrom TEXT,
            $columnAddedByAdminId TEXT,
            $columnProductRate REAL,
            $columnAddedTime TEXT
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // Insert Data
  Future<int> insertData(AllDataModel data) async {
    final db = await database;
    var res = await db.insert(tableData, data.toJson());
    return res;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<List<AllDataModel>> getAllData() async {
    final db = await database;
    var res = await db.query(tableData);
    List<AllDataModel> list =
        res.isNotEmpty ? res.map((c) => AllDataModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteAll(String tableName) async {
    final db = await database;
    db.rawDelete("delete from " + tableName);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(
      Map<String, dynamic> row, String tableName, String columnKey) async {
    Database db = await instance.database;
    int id = row[columnKey];
    return await db
        .update(tableName, row, where: columnKey + ' = ?', whereArgs: [id]);

    // String username = row[columnUsername];
    // return await db.update(tableName, row,
    //     where: '$columnUsername = ?', whereArgs: [username]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String tableName, String columnKey) async {
    Database db = await instance.database;
    return await db
        .delete(tableName, where: columnKey + ' = ?', whereArgs: [id]);
  }
}
