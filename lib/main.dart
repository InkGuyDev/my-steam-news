import 'package:flutter/material.dart';
import 'package:my_steam_news/pages/home.dart';


void main() {
  runApp(const MyApp());
}


// MyApp para controlar datos visuales de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySteamNews',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 51, 63, 84),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 100)),
        textTheme: TextTheme(
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: Homepage(title: 'Inicio',),
    );
  }
}

/*
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}*/
