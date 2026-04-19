// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgr_memory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgrMemoryModel _$PgrMemoryModelFromJson(Map<String, dynamic> json) =>
    PgrMemoryModel(
      name: json['name'] as String,
      wikiPath: json['wiki_path'] as String,
      imageUrl: json['image_url'] as String,
      starRating: (json['star_rating'] as num).toInt(),
      hp: (json['hp'] as num).toInt(),
      crit: (json['crit'] as num).toInt(),
      atk: (json['atk'] as num).toInt(),
      def: (json['def'] as num).toInt(),
    );

Map<String, dynamic> _$PgrMemoryModelToJson(PgrMemoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'wiki_path': instance.wikiPath,
      'image_url': instance.imageUrl,
      'star_rating': instance.starRating,
      'hp': instance.hp,
      'crit': instance.crit,
      'atk': instance.atk,
      'def': instance.def,
    };

PgrMemoriesPageModel _$PgrMemoriesPageModelFromJson(
  Map<String, dynamic> json,
) => PgrMemoriesPageModel(
  memories: (json['memories'] as List<dynamic>)
      .map((e) => PgrMemoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PgrMemoriesPageModelToJson(
  PgrMemoriesPageModel instance,
) => <String, dynamic>{'memories': instance.memories};
