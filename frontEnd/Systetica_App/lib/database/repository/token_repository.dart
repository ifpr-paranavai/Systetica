
import '../../model/Token.dart';
import '../ORM/token_orm.dart';
import '../db_sqlite.dart';

class TokenRepository {

  static Future<bool> insertToken(Token token) async {
    final db = await DbSQLite.instance.database;
    final id = await db.insert(TokenORM.TABLE, token.toJson());

    if (id > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> existToken() async {
    final db = await DbSQLite.instance.database;
    List<Map<String, Object?>> usuarios = await db.query(
      TokenORM.TABLE,
      columns: [TokenORM.ID],
    );
    return usuarios.isNotEmpty;
  }

  static Future<Token> findToken() async {
    final db = await DbSQLite.instance.database;

    final token = await db.query(TokenORM.TABLE);

    if (token.isNotEmpty) {
      return Token.fromJson(token.first);
    } else {
      return Token();
    }
  }

  static Future<bool> updateToken(Token token) async {
    final db = await DbSQLite.instance.database;
    final qtdeUpdate = await db.update(TokenORM.TABLE, token.toJson(),
        where: "id = ?", whereArgs: [token.id]);

    if (qtdeUpdate > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteUsuario(Token token) async {
    final db = await DbSQLite.instance.database;
    final qtdeUpdate = await db.delete(
        TokenORM.TABLE, where: "id = ?", whereArgs: [token.id]);

    if (qtdeUpdate > 0) {
      return true;
    } else {
      return false;
    }
  }
}
