// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgr_news_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgrNewsItemModel _$PgrNewsItemModelFromJson(Map<String, dynamic> json) =>
    PgrNewsItemModel(
      date: json['date'] as String,
      description: json['description'] as String,
      linkText: json['link_text'] as String?,
      linkUrl: json['link_url'] as String?,
    );

Map<String, dynamic> _$PgrNewsItemModelToJson(PgrNewsItemModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'description': instance.description,
      'link_text': instance.linkText,
      'link_url': instance.linkUrl,
    };
