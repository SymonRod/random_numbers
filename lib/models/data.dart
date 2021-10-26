import 'dart:math';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  int min;
  int max;
  int currentNumber;
  //final Random _random = Random();
  String hexColor;
  bool norepeat;
  bool noNumberLeft;
  List<int> allNumbers;

  Data(
      {required this.min,
      required this.max,
      required this.currentNumber,
      required this.hexColor,
      required this.norepeat,
      required this.noNumberLeft,
      required this.allNumbers});

  factory Data.fromJson(Map<String, dynamic> data) => _$DataFromJson(data);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
