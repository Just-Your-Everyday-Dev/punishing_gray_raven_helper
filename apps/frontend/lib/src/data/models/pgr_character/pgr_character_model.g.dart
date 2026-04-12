// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgr_character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgrCharacterModel _$PgrCharacterModelFromJson(Map<String, dynamic> json) =>
    PgrCharacterModel(
      name: json['name'] as String,
      wikiPath: json['wiki_path'] as String,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$PgrCharacterModelToJson(PgrCharacterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'wiki_path': instance.wikiPath,
      'image_url': instance.imageUrl,
    };
