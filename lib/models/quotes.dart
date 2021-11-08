import 'dart:math';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quotes.g.dart';

@JsonSerializable()
class Quote {
  late String quote;
  late int index;

  Quote({this.quote = "", this.index = 0});

  factory Quote.fromJson(Map<String, dynamic> data) => _$QuoteFromJson(data);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}

@JsonSerializable()
class Quotes {
  late List<Quote> quotes;

  Quotes({
    this.quotes = const <Quote>[],
  });

  factory Quotes.fromJson(Map<String, dynamic> data) => _$QuotesFromJson(data);

  Map<String, dynamic> toJson() => _$QuotesToJson(this);
}
