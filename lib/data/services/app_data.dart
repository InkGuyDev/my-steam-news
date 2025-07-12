import 'package:flutter/material.dart';

class Appdata extends ChangeNotifier {
  int _usageId = 0;
  bool _showNotifications = false; // Para mostrar notificaciones
  bool _darkMode = false; // Modo oscuro
  bool _initWithTheNews = false; // Iniciar con las novedades
  bool _initWithNewsOfHisGames = false; // Iniciar con los juegos que sigue
  int get usageId => _usageId;
  bool get showNotifications =>
      _showNotifications; // Para mostrar notificaciones
  bool get darkMode => _darkMode; // Modo oscuro
  bool get initWithTheNews => _initWithTheNews; // Iniciar con las novedades
  bool get initWithNewsOfHisGames =>
      _initWithNewsOfHisGames; // Iniciar con los juegos que sigue

  void setUsageID(int userId) {
    _usageId = userId;
    notifyListeners();
  }
}
