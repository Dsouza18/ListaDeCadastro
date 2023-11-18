import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_cadastro/provider/users.dart';
import 'package:lista_de_cadastro/user.dart';
import 'package:provider/provider.dart';

class UserForm extends  StatelessWidget{

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData ={};

  void _loadFormData(User user){
        _formData['id'] = user.id;
        _formData['name'] = user.name;
        _formData['email'] = user.email;
        _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {

    final User? user = ModalRoute.of(context)?.settings.arguments as User?;

    if (user != null) {
      _loadFormData(user);
    } else {
      print('Erro o valor esta nulo');
    }
      return Scaffold(
        appBar: AppBar(
          title: Center(
          child: Text(
              'Formulário de usuário',
            style: TextStyle(fontSize: 16.0),
          ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final isValid = _form.currentState!.validate();
                  if(isValid){
                    _form.currentState?.save();
                    Provider.of<UsersProvider>(context, listen: false).put(
                        User(
                            id: _formData['id'] ?? '',
                            name: _formData['name']!,
                            email: _formData['email']!,
                            avatarUrl: _formData['avatarUrl']!,
                          ),
                    );
                    Navigator.of(context).pop();
                     }
                  },
              )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'Digite um nome válido';
                    }
                    if(value.trim().length < 3){
                      return 'Digite um nome com no mínimo 3 letras';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'email'),
                  onSaved: (value) => _formData['email'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: InputDecoration(labelText: 'URL do Avatar'),
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                ),
              ],
            ),
          ),
        ),
      );
  }
}