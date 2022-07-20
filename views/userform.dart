import 'package:flutter/material.dart';
import 'package:appmae/models/user.dart';
import 'package:appmae/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) async {
    //puxa os dados dos usuarios cadastrados no banco de dados acessados
    _formData['id'] = user.id!;
    _formData['nome'] = user.nome;
    _formData['E-mail'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
    _formData['telefone'] = user.telefone;
    _formData['endereço'] = user.endereco;
    _formData['Cpf'] = user.cpf;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = ModalRoute.of(context)?.settings.arguments as User;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as User;

    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Clientes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              //o que acontece no botão de salvar
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    nome: _formData['nome']!,
                    email: _formData['E-mail']!,
                    avatarUrl: _formData['avatarUrl']!,
                    endereco: _formData['Endereço']!,
                    telefone: _formData['Telefone']!,
                    cpf: _formData['Cpf']!,
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        //partes para aceitar no formulario o numero correto de letras
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _formData['nome'],
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome inválido';
                    }

                    if (value.trim().length < 3) {
                      return 'Nome muito pequeno. No mínimo 3 letras.';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['nome'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['E-mail'],
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'E-mail inválido';
                    }

                    if (value.trim().length < 5) {
                      return 'Nome muito pequeno. No mínimo 5 letras.';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['E-mail'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'URL do Avatar'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Url inválido';
                    }

                    if (value.trim().length < 20) {
                      return 'Url muito pequeno. No mínimo 20 letras.';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['Url'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['endereço'],
                  decoration: const InputDecoration(labelText: 'Endereço'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Endereço inválido';
                    }

                    if (value.trim().length < 6) {
                      return 'Endereço muito pequeno. No mínimo 6 letras.';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['Endereço'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['telefone'],
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Telefone inválido';
                    }

                    if (value.trim().length < 8) {
                      return 'Falta numeros. No mínimo 8 numeros.';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['Telefone'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['Cpf'],
                  decoration: const InputDecoration(labelText: 'Cpf'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Cpf inválido';
                    }

                    if (value.trim().length < 11) {
                      return 'Cpf muito pequeno. No mínimo 11 numeros.';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['Cpf'] = value!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
