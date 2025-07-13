import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/app_data.dart';
import 'package:my_steam_news/no_connection_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_steam_news/pages/init.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => Appdata(), child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasConnection = true;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _monitorConnection();
  }

  void _monitorConnection() async {
    final initialStatus = await Connectivity().checkConnectivity();
    setState(
      () => _hasConnection = initialStatus[0] != ConnectivityResult.none,
    );

    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() => _hasConnection = result[0] != ConnectivityResult.none);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

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
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        navigationBarTheme: NavigationBarThemeData(
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(color: Colors.white),
          ),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
        ),
      ),
      home:
          _hasConnection
              ? const InitPage(title: 'Inicio')
              : const NoConnectionScreen(),
    );
  }
}
