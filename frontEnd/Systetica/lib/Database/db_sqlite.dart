import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:systetica/database/orm/token_orm.dart';

class DbSQLite {
  static final DbSQLite instance = DbSQLite._init();

  static Database? _database;

  DbSQLite._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('db_localHo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future dropTables() async {
    Database db = await instance.database;
  }

  static Future truncateTables() async {
    Database db = await instance.database;
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER NOT NULL';
    final intTypeNull = 'INTEGER';
    final doubleTyprNull = 'REAL';
    final textType = 'TEXT NOT NULL';
    final textTypeNull = 'TEXT';
    final varType = 'VARCHAR(255) NOT NULL';
    final varFKType = 'INTEGER';
    final dateTimeType = 'DATETIME';

    //Tabela ConfigServer
    await db.execute('''
    CREATE TABLE IF NOT EXISTS ${TokenORM.TABLE}(
    ${TokenORM.ID} $idType,
    ${TokenORM.ACCESS_TOKEN} $textType,
    ${TokenORM.REFRESH_TOKEN} $intType
    )''');
  }
}
