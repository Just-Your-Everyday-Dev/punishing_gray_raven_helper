import 'package:json_annotation/json_annotation.dart';

part 'pgr_character_model.g.dart';

@JsonSerializable()
class PgrCharacterModel {
  final String name;
  @JsonKey(name: 'wiki_path')
  final String wikiPath;
  @JsonKey(name: 'image_url')
  final String imageUrl;

  const PgrCharacterModel({
    required this.name,
    required this.wikiPath,
    required this.imageUrl,
  });

  factory PgrCharacterModel.fromJson(Map<String, dynamic> json) =>
      _$PgrCharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$PgrCharacterModelToJson(this);
}