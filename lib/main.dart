import 'package:aula_flutter/pages/cliente_form.dart';
import 'package:aula_flutter/pages/clientes_list.dart';
import 'package:aula_flutter/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmácia App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple[200],
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/lista_clientes': (context) => const ClientesList(),
        '/cliente_form': (context) => ClienteForm(),
      },
    );
  }
}
