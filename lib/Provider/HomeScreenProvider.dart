import 'package:flutter/material.dart';

class HomeScreenManager extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  setCurrentIndexValue(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
