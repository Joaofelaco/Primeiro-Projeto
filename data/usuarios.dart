import '../models/user.dart';
import 'db.dart';
import 'package:mysql1/mysql1.dart';

Map<String, User> s3 = {};
Map<String, User> dumy() {
  rdumy();
  return s3;
}

rdumy() async {
  //mostrar os usuarios na tela inicial
  Db db = Db();
  var s = await db.con();
  Results s2 = await s.query(
    'select id, nome, email, avatarUrl, endereco, telefone, cpf from clientes',
  );
  for (var i in s2) {
    s3[i[0].toString()] = User(
      id: i[0].toString(),
      nome: i[1],
      email: i[2].toString(),
      avatarUrl: i[3].toString(),
      endereco: i[4].toString(),
      telefone: i[5].toString(),
      cpf: i[6].toString(),
    );
  }
  s.close();
}

update(User u) async {
  //atualizar os usuarios
  Db db = Db();
  var s = await db.con();
  var s2 = await s.query(
      'update  clientes set nome = ?, email = ?, avatarUrl = ?, endereco = ?, telefone = ?, cpf = ?  where id = ? ;',
      [u.nome, u.email, u.avatarUrl, u.endereco, u.telefone, u.cpf, u.id]);
}

insert(User u, int i) async {
  //inserir/cadastrar usuario
  Db db = Db();
  var s = await db.con();
  Results s2 = await s.query(
      'insert into clientes (nome, telefone, cpf, endereco, email, avatarUrl) value (?, ?, ?, ?, ?, ?)',
      [u.nome, u.telefone, u.cpf, u.endereco, u.email, u.avatarUrl]);
  i = s2.insertId!;
}

delete(String id) async {
  //deletar usuario
  Db db = Db();
  var s = await db.con();
  Results s2 = await s.query('delete from clientes where id = ?', [id]);
}

























