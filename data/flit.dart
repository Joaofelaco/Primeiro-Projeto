/*import 'dart:io';

import 'package:appmae/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String tabelaNome = 'tabela_contato';
  String colId = 'id';
  String colNome = 'nome';
  String colEmail = 'email';
  String coltelefone = '';
  String colendereco = '';
  String colcpf = '';
  String colavatarUrl = '';
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    _databaseHelper;

    return _databaseHelper;
  }
  Future<Database> get database async {
    _database;

    return _database;
  }

  Future<Database> inicializaBanco() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String path = '${diretorio.path}user.db';

    var bandoDeContatos =
        await openDatabase(path, version: 1, onCreate: _criaBanco);
    return bandoDeContatos;
  }

  void _criaBanco(Database db, int versao) async {
    await db.execute('CREATE TABLE $tabelaNome('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colNome TEXT,'
        '$colEmail TEXT'
        '$coltelefone TEXT);'
        '$colendereco TEXT);'
        '$colcpf TEXT);'
        '$colavatarUrl TEXT);'
);
/*
De uma forma direta, esse seria o Banco de dados SQL
CREATE TABLE tabela_clientes(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome TEXT,
email TEXT
telefone TEXT
endereco TEXT
cpf TEXT
avatarUrl TEXT
);
*/
  }

  Future<List<Map<String, dynamic>>> getContatoMapList() async {
    Database db = await database;
    var result = await db.rawQuery("SELECT * FROM tabela_contato");
    return result;
  }

  Future<int> inserirContato(User contato) async {
    Database db = await database;
    var result = await db.insert(tabelaNome, contato.toMap());
    return result;
  }

  Future<int> atualizarContato(User contato, int id) async {
    var db = await database;
    var result = await db.rawUpdate(
        "UPDATE $tabelaNome SET $colNome = '${contato.nome}', $colEmail = '${contato.email}' WHERE $colId = '$id'");
    return result;
  }

  Future<int> apagarContato(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $tabelaNome WHERE $colId = $id');
    return result;
  }

  Future<List<User>> getListaDeContato() async {
    var contatoMapList = await getContatoMapList();
    int count = contatoMapList.length;
    List<User> listaDeContatos = <User>[];
    for (int i = 0; i < count; i++) {
      listaDeContatos.add(User.fromMapObject(contatoMapList[i]));
    }
    return listaDeContatos;
  }
}
*/