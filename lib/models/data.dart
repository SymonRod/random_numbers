import 'dart:math';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:random_numbers/models/quotes.dart';

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
  Quotes quotes = Quotes();

  Data({
    this.min = 10,
    this.max = 100,
    this.currentNumber = 1,
    this.hexColor = "#fffff",
    this.norepeat = true,
    this.noNumberLeft = false,
    this.allNumbers = const [1],
    required this.quotes,
  });

  factory Data.fromJson(Map<String, dynamic> data) => _$DataFromJson(data);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
