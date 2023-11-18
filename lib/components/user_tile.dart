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