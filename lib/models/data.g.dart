// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      min: json['min'] as int? ?? 10,
      max: json['max'] as int? ?? 100,
      currentNumber: json['currentNumber'] as int? ?? 1,
      hexColor: json['hexColor'] as String? ?? "#fffff",
      norepeat: json['norepeat'] as bool? ?? true,
      noNumberLeft: json['noNumberLeft'] as bool? ?? false,
      allNumbers: (json['allNumbers'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [1],
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
