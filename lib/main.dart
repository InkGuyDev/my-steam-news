import 'package:flutter/material.dart';
import 'package:my_steam_news/pages/init.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}


// MyApp para controlar datos visuales de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return MaterialApp(
      title: 'MySteamNews',
      theme: theme.copyWith(
        appBarTheme: AppBarTheme(
          systemOverlayStyle:
            colorScheme.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
          backgroundColor: colorScheme.brightness == Brightness.dark ? Colors.white : const Color.fromARGB(255, 11, 40, 64),
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white ),
        ),
        inputDecorationTheme:
          InputDecorationTheme(
            hintStyle: theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 51, 63, 84),
        textTheme: TextTheme(
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),
      /*ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 51, 63, 84),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 100)),
        textTheme: TextTheme(
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),*/
      home: InitPage(title: 'Inicio')
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
