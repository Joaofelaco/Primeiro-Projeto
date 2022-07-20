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

























/*import '../models/user.dart';

const DUMMY_USERS = {
  '1': User(
    id: '1',
    nome: 'Cris',
    email: 'cris@yahoo.com',
    avatarUrl:
        'https://cdn.pixabay.com/photo/2015/10/18/20/15/woman-995164_960_720.png',
    endereco: 'Rua São José - 638',
    telefone: '(48)4974-6895',
    cpf: '134.422.798-78',
  ),
  '2': User(
    id: '2',
    nome: 'luiz',
    email: 'lulu@hotmail.com',
    avatarUrl:
        'https://cdn.pixabay.com/photo/2017/02/23/13/05/avatar-2092113_960_720.png',
    endereco: 'Rua São Paulo - 619',
    telefone: '(44)9964-6391',
    cpf: '453.489.459-99',
  ),
  '3': User(
    id: '3',
    nome: 'Monique',
    email: 'mona@gmail.com',
    avatarUrl:
        'https://cdn.pixabay.com/photo/2016/03/31/20/27/avatar-1295773_1280.png',
    endereco: 'Rua Santo Antônio - 554',
    telefone: '(45)2174-7896',
    cpf: '123.684.340-45',
  ),
  '4': User(
    id: '4',
    nome: 'Gabriel',
    email: 'gab@hotmail.com',
    avatarUrl:
        'https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_960_720.png',
    endereco: 'Avenida Brasil - 532',
    telefone: '(41)8278-5825',
    cpf: '025.924.864-35',
  ),
  // '5': User(
  //id: '5',
  //nome: 'Gabriel',
  //email: 'gab@gmail.com',
  //avatarUrl:
  // 'https://cdn.pixabay.com/photo/2016/04/01/11/25/avatar-1300331_960_720.png',
  //endereco: 'Rua São Pedro - 458.',
  //telefone: '(49)5964-1893',
  // cpf: '842.576.472-84',
  //),
  //'6': User(
  // id: '6',
  // nome: 'Luiz',
  //email: 'luiz@hotmail.com',
  //  avatarUrl:
  //    'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png',
  //   endereco: 'Rua São João - 455.',
  // telefone: '(43)5974-9885',
  // cpf: '467.215.863-37',
  //),
  //'7': User(
  // id: '7',
  // nome: 'Monique',
  // email: 'mona@yahoo.com',
  // avatarUrl:
  //    'https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_1280.png',
  // endereco: 'Rua São Francisco - 442.',
  //telefone: '(46)7884-4855',
  // cpf: '222.353.110-07',
  //),
};
*/