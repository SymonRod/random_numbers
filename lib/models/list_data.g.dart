// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Element _$ElementFromJson(Map<String, dynamic> json) => Element(
      id: json['id'] as int? ?? 1,
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$ElementToJson(Element instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
    };

ListData _$ListDataFromJson(Map<String, dynamic> json) => ListData(
      elements: (json['elements'] as List<dynamic>)
          .map((e) => Element.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDataToJson(ListData instance) => <String, dynamic>{
      'elements': instance.elements,
    };
