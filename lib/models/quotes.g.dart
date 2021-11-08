// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      quote: json['quote'] as String? ?? "",
      index: json['index'] as int? ?? 0,
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'quote': instance.quote,
      'index': instance.index,
    };

Quotes _$QuotesFromJson(Map<String, dynamic> json) => Quotes(
      quotes: (json['quotes'] as List<dynamic>?)
              ?.map((e) => Quote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Quote>[],
    );

Map<String, dynamic> _$QuotesToJson(Quotes instance) => <String, dynamic>{
      'quotes': instance.quotes,
    };
