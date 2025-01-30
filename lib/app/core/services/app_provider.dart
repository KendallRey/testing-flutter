import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _secret = '';

  String get secret => _secret;

  void setSecret(String value) {
    _secret = value;
    notifyListeners();
  }
}
