import 'package:systetica/database/db_sqlite.dart';
import 'package:systetica/database/orm/token_orm.dart';
import 'package:systetica/model/TokenDTO.dart';

class TokenRepository {

  static Future<bool> insertToken(TokenDTO tokenDTO) async {
    final db = await DbSQLite.instance.database;
    final id = await db.insert(TokenORM.TABLE, tokenDTO.toJson());

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

  static Future<TokenDTO> findToken() async {
    final db = await DbSQLite.instance.database;

    final token = await db.query(TokenORM.TABLE);

    if (token.isNotEmpty) {
      return TokenDTO.fromJson(token.first);
    } else {
      return TokenDTO();
    }
  }

  static Future<bool> updateToken(TokenDTO tokenDTO) async {
    final db = await DbSQLite.instance.database;
    final qtdeUpdate = await db.update(TokenORM.TABLE, tokenDTO.toJson(),
        where: "id = ?", whereArgs: [tokenDTO.id]);

    if (qtdeUpdate > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteUsuario(TokenDTO tokenDTO) async {
    final db = await DbSQLite.instance.database;
    final qtdeUpdate = await db.delete(
        TokenORM.TABLE, where: "id = ?", whereArgs: [tokenDTO.id]);

    if (qtdeUpdate > 0) {
      return true;
    } else {
      return false;
    }
  }
}
