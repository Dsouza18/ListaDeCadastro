import 'package:flutter/material.dart';
import 'package:lista_de_cadastro/provider/users.dart';
import 'package:lista_de_cadastro/routes/app.routes.dart';
import 'package:lista_de_cadastro/views/user-form.dart';
import 'package:lista_de_cadastro/views/user_list.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UsersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.grey[900],
        ),
        themeMode: ThemeMode.dark,
        home: UserList(),
        routes: {
          AppRoute.HOME: (_) => UserList(),
          AppRoute.USER_FORM: (_) => UserForm(),
        },
      ),
    );
  }
}
