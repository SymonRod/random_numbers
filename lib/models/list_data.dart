import 'package:json_annotation/json_annotation.dart';

part 'list_data.g.dart';

@JsonSerializable()
class Element {
  int id;
  String content;

  Element({int this.id = 1, String this.content = ""});

  factory Element.fromJson(Map<String, dynamic> data) =>
      _$ElementFromJson(data);

  Map<String, dynamic> toJson() => _$ElementToJson(this);
}

@JsonSerializable()
class ListData {
  List<Element> elements;

  ListData({
    required this.elements,
  });

  factory ListData.fromJson(Map<String, dynamic> data) =>
      _$ListDataFromJson(data);

  Map<String, dynamic> toJson() => _$ListDataToJson(this);
}
