import 'package:mvs_rest/mvs_rest.dart';

class NewsBO {
  const NewsBO({
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

  final String id;
  final String title;
  final String titleTm;
  final String description;
  final String descriptionTm;
  final DateTime date;
  final int viewsCount;
  final int likesCount;
  final int priority;

  factory NewsBO.fromDto(NewsDto dto) {
    return NewsBO(
      id: dto.id,
      title: dto.title,
      titleTm: dto.titleTm,
      description: dto.description,
      descriptionTm: dto.descriptionTm,
      date: dto.date,
      viewsCount: dto.viewsCount,
      likesCount: dto.likesCount,
      priority: dto.priority,
    );
  }
}
