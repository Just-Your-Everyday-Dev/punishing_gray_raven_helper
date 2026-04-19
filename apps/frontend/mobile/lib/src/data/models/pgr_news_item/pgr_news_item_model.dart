import 'package:json_annotation/json_annotation.dart';

part 'pgr_news_item_model.g.dart';

@JsonSerializable()
class PgrNewsItemModel {
  final String date;
  final String description;
  @JsonKey(name: 'link_text')
  final String? linkText;
  @JsonKey(name: 'link_url')
  final String? linkUrl;

  const PgrNewsItemModel({
    required this.date,
    required this.description,
    this.linkText,
    this.linkUrl,
  });

  factory PgrNewsItemModel.fromJson(Map<String, dynamic> json) =>
      _$PgrNewsItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PgrNewsItemModelToJson(this);
}