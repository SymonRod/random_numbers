import 'package:flutter/material.dart';
import 'dart:math';

class Data with ChangeNotifier {
  int _min = 33;
  int _max = 66;
  int _currentNumber = 0;
  final Random _random = Random();

  void newRandom() {
    var pool = _max - _min;
    _currentNumber = _min + _random.nextInt(pool);
    notifyListeners();
  }

  int get currentNumber => _currentNumber;
  int get min => _min;
  int get max => _max;

  set max(newMax) {
    if (newMax > _min) {
      _max = newMax;
      notifyListeners();
    }
  }

  set min(newMin) {
    if (newMin < max) {
      _min = newMin;
      notifyListeners();
    }
  }
}
