import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _username = 'Invitado';
  bool _resetEnabled = true;

  int get counter => _counter;
  String get username => _username;
  bool get resetEnabled => _resetEnabled;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void resetCounter() {
    if (_resetEnabled) {
      _counter = 0;
      notifyListeners();
    }
  }

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void setResetEnabled(bool value) {
    _resetEnabled = value;
    notifyListeners();
  }
}
