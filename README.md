[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/xUDSX77E)
<p align="center">
  <img src="https://inscricao.ucsal.br/wp-content/uploads/2023/07/Logo-UCSAL.svg" alt="UCSAL Logo">
</p>

<h1 align="center">TRABALHO AVII-<br> Aplicativo lista de cadastro de usuário</h1>

Este é um projeto simples de lista de cadastro desenvolvido em Flutter. A aplicação permite visualizar, adicionar, editar e excluir usuários.

## Instalação do Flutter

Este guia fornece instruções passo a passo para instalar o Flutter no seu sistema.

### Pré-requisitos

Certifique-se de ter os seguintes pré-requisitos instalados no seu sistema:

- [Git](https://git-scm.com/)
- [Flutter SDK](https://flutter.dev/docs/get-started/install)

### Passos para a Instalação

1. **Clone o Repositório do Flutter:**

   Abra um terminal e execute o seguinte comando para clonar o repositório do Flutter:

   ```bash
   git clone https://github.com/flutter/flutter.git
   ```


Certamente! Aqui está o README.md formatado:

markdown
Copy code
# Lista de Cadastro Flutter

Este é um projeto simples de lista de cadastro desenvolvido em Flutter. A aplicação permite visualizar, adicionar, editar e excluir usuários.

## Instalação do Flutter

Este guia fornece instruções passo a passo para instalar o Flutter no seu sistema.

### Pré-requisitos

Certifique-se de ter os seguintes pré-requisitos instalados no seu sistema:

- [Git](https://git-scm.com/)
- [Flutter SDK](https://flutter.dev/docs/get-started/install)

### Passos de Instalação

1. **Clone o Repositório do Flutter:**

   Abra um terminal e execute o seguinte comando para clonar o repositório do Flutter:

   ```bash
   git clone https://github.com/flutter/flutter.git
   ```
2. Adicione o Flutter ao seu PATH:

Adicione o caminho para o diretório bin do Flutter ao seu PATH. Isso pode ser feito editando o arquivo de perfil do seu shell (por exemplo, ~/.bashrc, ~/.zshrc, ou ~/.bash_profile) e adicionando a seguinte linha:

Copy code
```bash
export PATH="$PATH:`caminho/para/o/diretorio/flutter/bin`"
```
Em seguida, execute o comando para aplicar as alterações:

Copy code
```bash
source ~/.bashrc
```
ou
Copy code
```bash
source ~/.zshrc
```
3. Verifique a Instalação do Flutter:

Execute o seguinte comando para verificar se o Flutter foi instalado corretamente:

Copy code
```bash
flutter doctor
```
Siga as instruções fornecidas pelo comando flutter doctor para instalar quaisquer dependências adicionais necessárias.

## Desenvolvimento do Projeto

1. UserTile Widget
   O UserTile é um widget que representa um item de usuário na lista. Ele exibe o avatar, nome e e-mail do usuário, além de botões de edição e exclusão.

Código: lib/components/user_tile.dart

Copy code
``` dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_cadastro/provider/users.dart';
import 'package:lista_de_cadastro/routes/app.routes.dart';
import 'package:lista_de_cadastro/user.dart';
import 'package:provider/provider.dart';


class UserTile extends StatelessWidget{

final User user;

const UserTile(this.user, {required TextStyle textStyle});

@override
Widget build(BuildContext context) {
final avatar  = user.avatarUrl == null || user.avatarUrl.isEmpty
? CircleAvatar(child: Icon(Icons.person))
: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
return ListTile(
leading: avatar,
title: Text(user.name),
subtitle: Text(user.email),
trailing: Container(
width: 100,
child:Row(
children: <Widget>[
IconButton(
icon: Icon(Icons.edit),
color: Colors.blue,
onPressed: () {
Navigator.of(context).pushNamed(
AppRoute.USER_FORM,
arguments: user,
);
},
),
IconButton(
icon: Icon(Icons.delete),
color: Colors.red,
onPressed: () {
showDialog(
context: context,
builder: (ctx) => AlertDialog(
title: Text('Excluir usuário'),
content: Text('Tem certeza?'),
actions: <Widget>[
TextButton(
onPressed: () {
Navigator.of(ctx).pop();
},
child: Text('Cancelar'),
),
TextButton(
onPressed: () {
Provider.of<UsersProvider>(context, listen: false).remove(user);
Navigator.of(ctx).pop();
},
child: Text('Confirmar'),
),
],
),
);
},
)
],
),
));
}
}

```

2. UsersProvider
   UsersProvider é a classe que gerencia a lista de usuários. Ela fornece métodos para adicionar, editar e excluir usuários.

Código: lib/provider/users.dart

``` dart
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lista_de_cadastro/data/dummy_users.dart';
import 'package:lista_de_cadastro/user.dart';

class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        !user.id.trim().isEmpty &&
        _items.containsKey(user.id)) {
      _items.update(user.id, (_) => User(id: user.id, name: user.name, email: user.email, avatarUrl: user.avatarUrl));
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(id, () => User(
        id: id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ));
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user?.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}


3. UserForm Widget
   O UserForm é um widget que permite adicionar ou editar um usuário. Ele contém um formulário com campos para nome, e-mail e URL do avatar.

Código: lib/views/user_form.dart

```

```dart


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
```

4. UserList Widget
   O UserList exibe a lista de usuários usando o ListView.builder e permite a navegação para o formulário de usuário para adicionar novos usuários.

Código: lib/views/user_list.dart

``` dart
Copy code

import 'package:flutter/material.dart';
import 'package:lista_de_cadastro/components/user_tile.dart';
import 'package:lista_de_cadastro/provider/users.dart';
import 'package:lista_de_cadastro/routes/app.routes.dart';
import 'package:lista_de_cadastro/user.dart';
import 'package:provider/provider.dart';


class UserList extends StatelessWidget{
const UserList({super.key});

@override
Widget build(BuildContext context){
final UsersProvider users = Provider.of(context);
return Scaffold(
appBar: AppBar(
title: Center(
child: Text(
'Lista de usuários ',
textAlign: TextAlign.center,
style: TextStyle(fontSize: 18.0),
),
),
backgroundColor: Theme.of(context).primaryColor,
actions: <Widget>[
IconButton(
onPressed: () {
Navigator.of(context).pushNamed(
AppRoute.USER_FORM
);
},
icon: Icon(Icons.add),
),
],
),
body: ListView.builder(
itemCount: users.count,
itemBuilder: (ctx, i) => UserTile(users.byIndex(i), textStyle: TextStyle(fontSize: 18)),
),
);
}
}
```

## Trechos de Código Relevantes
Alguns trechos de código relevantes para entender a estrutura e lógica do projeto:

-lib/main.dart
-lib/routes/app.routes.dart

## Resultado:

https://github.com/Dsouza18/ListaDeCadastro/assets/99992634/9efd510c-dc4b-4893-9095-cf3f18b2f5e7

## Links

- Repositório: [GitHub](https://github.com/Dsouza18/ListaDeCadastro.git)

# Conclusão
Este projeto é um exemplo simples de lista de cadastro em Flutter.

## Desenvolvedores do projeto

| Daniel Santos | Felipe Brito |

