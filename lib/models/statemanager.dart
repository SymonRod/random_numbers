import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';

import 'package:random_numbers/models/data.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class StateManager with ChangeNotifier {
  String saveFile = "assets/data.json";
  Color _appMainColor = Colors.red;
  final Random _random = Random();

  late Data userData;

  StateManager() {
    new File(saveFile).createSync(recursive: true);

    var file = File("data/data.json");
    var content = file.readAsStringSync();
    try {
      var jsonData = json.decode(content);
      userData = Data.fromJson(jsonData);
      _appMainColor = HexColor.fromHex(userData.hexColor);
    } catch (e) {
      userData = Data(
          min: 0,
          max: 100,
          currentNumber: 0,
          hexColor: "#2ACAEA",
          norepeat: false,
          noNumberLeft: false,
          allNumbers: []);
    }
  }

  void save() {
    var file = File("data/data.json");
    var color = _appMainColor.toHex();
    userData.hexColor = color;
    file.writeAsString(json.encode(userData.toJson()));
  }

  void newRandom() {
    var pool = userData.max - userData.min;

    if (userData.allNumbers.length + 1 == pool && userData.norepeat) {
      userData.noNumberLeft = true;
      notifyListeners();
      return;
    }

    int number;
    userData.allNumbers.add(userData.currentNumber);
    number = _random.nextInt(pool);

    if (userData.norepeat) {
      while (true) {
        var newNumber = true;
        for (var numberInList in userData.allNumbers) {
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
    userData.currentNumber = number;

    save();
    notifyListeners();
  }

  int get currentNumber => userData.currentNumber;
  int get min => userData.min;
  int get max => userData.max;
  bool get norepeat => userData.norepeat;
  bool get noNumberLeft => userData.noNumberLeft;
  Color get appMainColor => _appMainColor;

  get allNumbers => userData.allNumbers;

  void resetNumbers() {
    userData.noNumberLeft = false;
    userData.allNumbers.clear();
    save();
    notifyListeners();
  }

  set appMainColor(Color color) {
    _appMainColor = color;
    save();
    notifyListeners();
  }

  set norepeat(bool value) {
    userData.norepeat = value;
    save();
    notifyListeners();
  }

  set max(int newMax) {
    if (newMax > userData.min) {
      userData.max = newMax;
      notifyListeners();
    }
    save();
  }

  set min(int newMin) {
    if (newMin < max) {
      userData.min = newMin;
      notifyListeners();
    }
    save();
  }
}