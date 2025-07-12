import 'package:flutter/material.dart';

class Appdata extends ChangeNotifier {
  int _usageId = 0;
  int get usageId => _usageId;

  void setUsageID(int userId) {
    _usageId = userId;
    notifyListeners();
  }
}
