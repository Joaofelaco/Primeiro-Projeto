import 'dart:async';
import 'package:mysql1/mysql1.dart';

class Db {
  Db();

  Future con() async {
    // abrir a conexão (testando se a db  existe)
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '192.168.0.254',
        port: 3306,
        user: 'joao',
        db: 'cadastros',
        password: 'senha'));

    return conn;
  }

  close(final c) async {
    c.query('');
  }
}
