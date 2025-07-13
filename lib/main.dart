import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/app_data.dart';
import 'package:provider/provider.dart';
import 'package:my_steam_news/pages/init.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => Appdata(), child: const MyApp()),
  );
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
          backgroundColor:
              colorScheme.brightness == Brightness.dark
                  ? Colors.white
                  : const Color.fromARGB(255, 11, 40, 64),
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: theme.inputDecorationTheme.hintStyle,
          border: InputBorder.none,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 51, 63, 84),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        navigationBarTheme: NavigationBarThemeData(
          iconTheme: WidgetStateProperty.all(const IconThemeData(color: Colors.white),),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              color: Colors.white,
              //fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      /*ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 51, 63, 84),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 100)),
        textTheme: TextTheme(
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),*/
      home: InitPage(title: 'Inicio'),
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
