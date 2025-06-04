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
    // if (user == null) { 
    //   return;
    // }

    
    if (user.id != null &&
        user.id!.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      try {
        await update(user); 
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
        print('Erro ao atualizar usuário: $e');
        return;
      }
    } else {
      
      try {
        

        User userWithPotentiallyNoId = User( 
            id: null, 
            nome: user.nome,
            email: user.email,
            avatarUrl: user.avatarUrl,
            endereco: user.endereco,
            telefone: user.telefone,
            cpf: user.cpf,
        );

        
        int generatedIdPlaceholder = 0; 
        await insert(userWithPotentiallyNoId, generatedIdPlaceholder);                                                                

      } catch (e) {
        print('Erro ao inserir usuário: $e');
        return;
      }
    }
    notifyListeners();
  }

  Future<void> remove(User user) async { 
    if (user.id != null) {
      try {
        await delete(user.id!); 
        _items.remove(user.id);
        notifyListeners();
      } catch (e) {
        print('Erro ao excluir usuário: $e');
        return;
      }
    }
  }
}
