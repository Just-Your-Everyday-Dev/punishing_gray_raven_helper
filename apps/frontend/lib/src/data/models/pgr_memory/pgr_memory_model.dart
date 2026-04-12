import 'package:json_annotation/json_annotation.dart';

part 'pgr_memory_model.g.dart';

@JsonSerializable()
class PgrMemoryModel {
  final String name;
  @JsonKey(name: 'wiki_path')
  final String wikiPath;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'star_rating')
  final int starRating;
  final int hp;
  final int crit;
  final int atk;
  final int def;

  const PgrMemoryModel({
    required this.name,
    required this.wikiPath,
    required this.imageUrl,
    required this.starRating,
    required this.hp,
    required this.crit,
    required this.atk,
    required this.def,
  });

  factory PgrMemoryModel.fromJson(Map<String, dynamic> json) =>
      _$PgrMemoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PgrMemoryModelToJson(this);
}

@JsonSerializable()
class PgrMemoriesPageModel {
  final List<PgrMemoryModel> memories;

  const PgrMemoriesPageModel({required this.memories});

  factory PgrMemoriesPageModel.fromJson(Map<String, dynamic> json) =>
      _$PgrMemoriesPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PgrMemoriesPageModelToJson(this);

  List<PgrMemoryModel> byStarRating(int stars) =>
      memories.where((m) => m.starRating == stars).toList();
}