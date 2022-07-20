import 'dart:core';

//aonde esta definido cada campo do app na parte do usuario
class User {
  final String? id;
  final String nome;
  final String telefone;
  final String cpf;
  final String endereco;
  final String email;
  final String avatarUrl;

  const User({
    this.id,
    required this.nome,
    required this.email,
    required this.avatarUrl,
    required this.endereco,
    required this.telefone,
    required this.cpf,
  });

  User.fromjson(Map<String, dynamic> json, this.id, this.nome, this.telefone,
      this.cpf, this.endereco, this.email, this.avatarUrl);

  //Map<String, Object?> toMap() {}

  //static User fromMapObject(Map<String, dynamic> contatoMapList) {}
}
