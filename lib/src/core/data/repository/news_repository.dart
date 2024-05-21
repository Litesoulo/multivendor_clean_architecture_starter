import 'dart:async';

import 'package:mvs_database/mvs_database.dart';
import 'package:mvs_rest/mvs_rest.dart';

import '../../domain/entity/fact/news_bo.dart';

abstract class INewsRepository {
  const INewsRepository();

  FutureOr<List<NewsBO>> getNews();
}

class NewsRepository implements INewsRepository {
  final INewsAPI _newsAPI;
  final IMVSDAO<NewsDatabaseTableData> _newsDAO;

  NewsRepository({
    required INewsAPI newsAPI,
    required IMVSDAO<NewsDatabaseTableData> newsDAO,
  })  : _newsAPI = newsAPI,
        _newsDAO = newsDAO;

  @override
  FutureOr<List<NewsBO>> getNews() async {
    final news = await _newsAPI.getNews();

    return List<NewsBO>.from(
      news.map(
        (e) => NewsBO.fromDto(e),
      ),
    );
  }
}
