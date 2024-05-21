import 'package:json_annotation/json_annotation.dart';

part '../../../../../generated/src/data/data/dto/news/news_dto.g.dart';

@JsonSerializable()
class NewsDto {
  const NewsDto({
    required this.id,
    required this.title,
    required this.titleTm,
    required this.description,
    required this.descriptionTm,
    required this.date,
    required this.viewsCount,
    required this.likesCount,
    required this.priority,
  });

  factory NewsDto.fromJson(Map<String, Object?> json) => _$NewsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDtoToJson(this);

  @JsonKey(
    name: "id",
  )
  final String id;
  @JsonKey(
    name: "title",
  )
  final String title;
  @JsonKey(
    name: "titleTm",
  )
  final String titleTm;
  @JsonKey(
    name: "description",
  )
  final String description;
  @JsonKey(
    name: "descriptionTm",
  )
  final String descriptionTm;
  @JsonKey(
    name: "date",
  )
  final DateTime date;
  @JsonKey(
    name: "viewsCount",
  )
  final int viewsCount;
  @JsonKey(
    name: "likesCount",
  )
  final int likesCount;
  @JsonKey(
    name: "priority",
  )
  final int priority;
}
