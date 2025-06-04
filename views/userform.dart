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
  bool _isInit = true; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        final user = arguments as User;
        _loadFormData(user);
      }
    }
    _isInit = false;
  }

  void _loadFormData(User user) {
    
    _formData['id'] = user.id ?? ''; 
    _formData['nome'] = user.nome;
    _formData['email'] = user.email; 
    _formData['avatarUrl'] = user.avatarUrl;
    _formData['telefone'] = user.telefone; 
    _formData['endereco'] = user.endereco; 
    _formData['cpf'] = user.cpf; 
  }

  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)?.settings.arguments as User?;

    return Scaffold(
      appBar: AppBar(
        title: _formData['id'] != null && _formData['id']!.isNotEmpty
            ? const Text('Editar Cliente')
            : const Text('Cadastro de Clientes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState?.validate() ?? false;

              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    nome: _formData['nome']!,
                    email: _formData['email']!, 
                    avatarUrl: _formData['avatarUrl']!,
                    endereco: _formData['endereco']!, 
                    telefone: _formData['telefone']!, 
                    cpf: _formData['cpf']!, 
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTextFormField(
                  initialValue: _formData['nome'],
                  labelText: 'Nome Completo',
                  hintText: 'Digite o nome completo',
                  onSaved: (value) => _formData['nome'] = value!,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome inválido';
                    }
                    if (value.trim().length < 3) {
                      return 'Nome muito pequeno. No mínimo 3 letras.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), 
                _buildTextFormField(
                  initialValue: _formData['email'],
                  labelText: 'E-mail',
                  hintText: 'exemplo@dominio.com',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _formData['email'] = value!, 
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'E-mail inválido';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                        return 'E-mail com formato inválido.';
                    }
                    if (value.trim().length < 5) {
                      return 'E-mail muito pequeno. No mínimo 5 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), 
                _buildTextFormField(
                  initialValue: _formData['avatarUrl'],
                  labelText: 'URL do Avatar',
                  hintText: 'http://.../imagem.png',
                  onSaved: (value) => _formData['avatarUrl'] = value!, 
                  validator: (value) {
                    // Validação básica de URL (pode ser melhorada)
                    bool isValidUrl = Uri.tryParse(value ?? '')?.hasAbsolutePath ?? false;
                    if (value == null || value.trim().isEmpty) {
                        return 'URL inválida';
                    }
                    if (!isValidUrl) {
                        return 'Por favor, insira uma URL válida.';
                    }                    
                    return null;
                  },
                ),
                const SizedBox(height: 16), 
                _buildTextFormField(
                  initialValue: _formData['endereco'],
                  labelText: 'Endereço',
                  hintText: 'Rua, Número, Bairro, Cidade',
                  onSaved: (value) => _formData['endereco'] = value!, /
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Endereço inválido';
                    }
                    if (value.trim().length < 6) {
                      return 'Endereço muito pequeno. No mínimo 6 letras.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), 
                _buildTextFormField(
                  initialValue: _formData['telefone'],
                  labelText: 'Telefone',
                  hintText: '(XX) XXXXX-XXXX',
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => _formData['telefone'] = value!, 
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Telefone inválido';
                    }
                    if (value.trim().length < 8) { 
                      return 'Número de telefone muito curto.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), 
                _buildTextFormField(
                  initialValue: _formData['cpf'],
                  labelText: 'CPF',
                  hintText: '000.000.000-00',
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _formData['cpf'] = value!, 
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'CPF inválido';
                    }
                    if (value.trim().replaceAll(RegExp(r'[^0-9]'), '').length != 11) {
                      return 'CPF deve conter 11 dígitos.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24), 
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _buildTextFormField({
    String? initialValue,
    required String labelText,
    String? hintText,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextInputType? keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
