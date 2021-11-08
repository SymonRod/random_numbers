import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:random_numbers/models/data.dart';
import 'package:random_numbers/models/quotes.dart';

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
  String saveFile = "";
  Color _appMainColor = Colors.red;
  final Random _random = Random();
  var directory;
  Data userData = Data(quotes: Quotes());

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    } else if (kIsWeb) {
      var webInfo = await deviceInfo.webBrowserInfo;
      return (webInfo.vendor! +
          webInfo.userAgent! +
          webInfo.hardwareConcurrency.toString());
    }
  }

  void _init() async {
    directory = await getApplicationDocumentsDirectory();
    saveFile = '${directory.path}/data.json';
    var unique_id = await _getId();
    var file = await File(saveFile).create(recursive: true);

    var content = file.readAsStringSync();
    Data tempData;
    try {
      var jsonData = json.decode(content);
      tempData = Data.fromJson(jsonData);
      _appMainColor = HexColor.fromHex(tempData.hexColor);
    } catch (e) {
      tempData = Data(
          min: 0,
          max: 100,
          currentNumber: 0,
          hexColor: "#2ACAEA",
          norepeat: false,
          noNumberLeft: false,
          allNumbers: [],
          quotes: Quotes());
    }
    userData = tempData;
    notifyListeners();
  }

  StateManager() {
    _init();
  }

  void save() async {
    var file = File(saveFile);
    var color = _appMainColor.toHex();
    userData.hexColor = color;
    file.writeAsString(json.encode(userData.toJson()));
  }

  void newRandom() {
    var pool = userData.max - userData.min;

    if (userData.allNumbers.length + 1 >= pool && userData.norepeat) {
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
