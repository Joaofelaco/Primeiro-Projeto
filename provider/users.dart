import 'package:flutter/material.dart';
import 'package:appmae/models/user.dart';
import '../data/usuarios.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = dumy();
  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    if (user.id != null && //diferente de nulo
        user.id!.trim().isNotEmpty && //nao estiver vazio
        _items.containsKey(
          //estiver contido dentro do map
          user.id,
        )) {
      try {
        //atualizar o usuario
        update(user);
        _items.update(
          user.id!,
          (_) => User(
            id: user.id,
            nome: user.nome,
            email: user.email,
            avatarUrl: user.avatarUrl,
            endereco: user.endereco,
            telefone: user.telefone,
            cpf: user.cpf,
          ),
        );
      } catch (e) {
        return;
      }
    } else {
      //se nao tiver usuario criar um
      try {
        int i = 0;
        insert(user, i);
        final id = i.toString();
        _items.putIfAbsent(
          id,
          () => User(
            id: id,
            nome: user.nome,
            email: user.email,
            avatarUrl: user.avatarUrl,
            endereco: user.endereco,
            telefone: user.telefone,
            cpf: user.cpf,
          ),
        );
      } catch (e) {
        return;
      }
    }

    notifyListeners();
  }

  void remove(User user) {
    //deletar o usuario
    if (user != null && user.id != null) {
      try {
        delete(user.id!);
        _items.remove(user.id);
        notifyListeners();
      } catch (e) {
        return;
      }
    }
  }
}

//put =>adicionar ou alterar elemento ja existente
//metodo trim tirar os espaços em branco
