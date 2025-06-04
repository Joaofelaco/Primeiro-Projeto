import 'package:appmae/provider/users.dart';
import 'package:appmae/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:appmae/models/user.dart';
import 'package:appmae/componentes/usertile.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<Users>(context); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'), 
        // ações são herdadas do AppBarTheme em main.dart se definido
      ),
      body: usersProvider.count == 0
          ? Center( 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum cliente cadastrado.',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Clique no botão "+" para adicionar um novo cliente.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0), 
              itemCount: usersProvider.count,
              itemBuilder: (context, i) => UserTile(usersProvider.byIndex(i)),
            ),
      floatingActionButton: FloatingActionButton( 
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.USER_FORM,
            arguments: const User( 
              id: null, 
              nome: '',
              email: '',
              avatarUrl: '',
              cpf: '',
              endereco: '',
              telefone: '',
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor, 
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Adicionar Cliente',
      ),
    );
  }
}
