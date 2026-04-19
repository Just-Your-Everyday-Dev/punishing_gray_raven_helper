// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgr_home_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgrHomePageModel _$PgrHomePageModelFromJson(Map<String, dynamic> json) =>
    PgrHomePageModel(
      characters: (json['characters'] as List<dynamic>)
          .map((e) => PgrCharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingCharacters: (json['upcoming_characters'] as List<dynamic>)
          .map((e) => PgrCharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      news: (json['news'] as List<dynamic>)
          .map((e) => PgrNewsItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PgrHomePageModelToJson(PgrHomePageModel instance) =>
    <String, dynamic>{
      'characters': instance.characters,
      'upcoming_characters': instance.upcomingCharacters,
      'news': instance.news,
    };
