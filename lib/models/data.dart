import 'package:flutter/material.dart';
import 'dart:math';

class Data with ChangeNotifier {
  int _min = 0;
  int _max = 100;
  int _currentNumber = 0;
  final Random _random = Random();
  Color _appMainColor = Colors.red;
  bool _norepeat = false;
  bool _noNumberLeft = false;

  List<int> allNumbers = [
    0,
  ];

  void newRandom() {
    var pool = _max - _min;

    if (allNumbers.length + 1 == pool && _norepeat) {
      _noNumberLeft = true;
      notifyListeners();
      return;
    }

    int number;
    allNumbers.add(_currentNumber);
    number = _random.nextInt(pool);

    if (_norepeat) {
      while (true) {
        var newNumber = true;
        for (var numberInList in allNumbers) {
          if (number == numberInList) {
            newNumber = false;
          }
        }
        if (newNumber) {
          break;
        }
        number = _random.nextInt(pool);
      }
    }
    _currentNumber = number;
    notifyListeners();
  }

  int get currentNumber => _currentNumber;
  int get min => _min;
  int get max => _max;
  bool get norepeat => _norepeat;
  Color get appMainColor => _appMainColor;

  void resetNumbers() {
    allNumbers.clear();
    notifyListeners();
  }

  set appMainColor(Color color) {
    _appMainColor = color;
    notifyListeners();
  }

  set norepeat(bool value) {
    _norepeat = value;
    notifyListeners();
  }

  set max(int newMax) {
    if (newMax > _min) {
      _max = newMax;
      notifyListeners();
    }
  }

  set min(int newMin) {
    if (newMin < max) {
      _min = newMin;
      notifyListeners();
    }
  }
}
