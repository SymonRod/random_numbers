import 'dart:math';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:random_numbers/models/quotes.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  String uuid;
  int min;
  int max;
  int currentNumber;
  //final Random _random = Random();
  String hexColor;
  bool norepeat;
  bool noNumberLeft;
  List<int> allNumbers;

  Data({
    this.uuid = "ffffffffffff",
    this.min = 10,
    this.max = 100,
    this.currentNumber = 1,
    this.hexColor = "#fffff",
    this.norepeat = true,
    this.noNumberLeft = false,
    required this.allNumbers,
  });

  factory Data.fromJson(Map<String, dynamic> data) => _$DataFromJson(data);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
