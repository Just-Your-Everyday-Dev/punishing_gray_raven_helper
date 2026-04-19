import 'package:json_annotation/json_annotation.dart';

import '../pgr_character/pgr_character_model.dart';
import '../pgr_news_item/pgr_news_item_model.dart';

part 'pgr_home_page_model.g.dart';

@JsonSerializable()
class PgrHomePageModel {
  final List<PgrCharacterModel> characters;
  @JsonKey(name: 'upcoming_characters')
  final List<PgrCharacterModel> upcomingCharacters;
  final List<PgrNewsItemModel> news;

  const PgrHomePageModel({
    required this.characters,
    required this.upcomingCharacters,
    required this.news,
  });

  factory PgrHomePageModel.fromJson(Map<String, dynamic> json) =>
      _$PgrHomePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PgrHomePageModelToJson(this);
}