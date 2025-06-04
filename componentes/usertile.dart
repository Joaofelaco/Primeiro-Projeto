import 'package:appmae/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:appmae/models/user.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';

class UserTile extends StatelessWidget {
  final User? user;

  const UserTile(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user == null) {      
      return const SizedBox.shrink();
    }

    final avatar = user!.avatarUrl.isEmpty
        ? CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight,
            child: Icon(
              Icons.person,
              color: Theme.of(context).primaryColorDark, 
            ))
        : CircleAvatar(backgroundImage: NetworkImage(user!.avatarUrl));

    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
        leading: avatar,
        title: Text(user!.nome, style: const TextStyle(fontWeight: FontWeight.w500)), 
        subtitle: Text(user!.telefone),
        trailing: SizedBox(
          width: 100, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Alinhar ícones ao final
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                // color: Colors.orange.shade700, 
                color: Theme.of(context).primaryColorDark, 
                tooltip: 'Editar', 
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error, 
                tooltip: 'Excluir', 
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog( 
                      title: const Text('Excluir Usuário'),
                      content: const Text('Tem certeza que deseja excluir este usuário?'),
                      actions: [
                        TextButton(
                          child: const Text('Não'),
                          onPressed: () => Navigator.of(ctx).pop(false),
                        ),
                        TextButton(
                          child: Text(
                            'Sim',
                            style: TextStyle(color: Theme.of(context).colorScheme.error), // Cor de ação destrutiva
                          ),
                          onPressed: () => Navigator.of(ctx).pop(true),
                        ),
                      ],
                    ),
                  ).then((confirmed) {
                    if (confirmed != null && confirmed) {
                      Provider.of<Users>(context, listen: false).remove(user!);
                    }
                  });
                },
              ),
            ],
          ),
        ));
  }
}
