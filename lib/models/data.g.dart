// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      min: json['min'] as int,
      max: json['max'] as int,
      currentNumber: json['currentNumber'] as int,
      hexColor: json['hexColor'] as String,
      norepeat: json['norepeat'] as bool,
      noNumberLeft: json['noNumberLeft'] as bool,
      allNumbers:
          (json['allNumbers'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'currentNumber': instance.currentNumber,
      'hexColor': instance.hexColor,
      'norepeat': instance.norepeat,
      'noNumberLeft': instance.noNumberLeft,
      'allNumbers': instance.allNumbers,
    };
