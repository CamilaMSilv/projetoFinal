import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MaterialApp",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light, // Define o tema como dark
          primaryColor: Colors.blue, //cor primaria do APP
          fontFamily: 'Roboto', // Fonte padrão do aplicativo
          appBarTheme: const AppBarTheme(color: Colors.deepPurple),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("AppBar"),
            actions: const [Icon(Icons.exit_to_app), Icon(Icons.edit_note)],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Container(width: 100, height: 50, color: Colors.yellow, margin: const EdgeInsets.all(5)),
            Container(width: 200, height: 50, color: Colors.red, margin: const EdgeInsets.all(5)),
            Container(width: 300, height: 50, color: Colors.green, margin: const EdgeInsets.all(5)),
            Container(width: 400, height: 50, color: Colors.blue, margin: const EdgeInsets.all(5)),
          ]),
          drawer: const Drawer(),
          bottomNavigationBar: BottomNavigationBar(items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ]),
          floatingActionButton: const FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add),
          ),
        ));
  }
}
