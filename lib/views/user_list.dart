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