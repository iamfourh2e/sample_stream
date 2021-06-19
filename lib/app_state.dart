import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String? token = "mother fker";

  void setToken(val) {
    token = val;
    notifyListeners();
  }
}
