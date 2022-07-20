import 'package:appmae/provider/users.dart';
import 'package:appmae/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:appmae/models/user.dart';
import 'package:appmae/componentes/usertile.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  get child => null;

  get data => null;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: const User(
                  id: '',
                  nome: '',
                  email: '',
                  avatarUrl: '',
                  cpf: '',
                  endereco: '',
                  telefone: '',
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
