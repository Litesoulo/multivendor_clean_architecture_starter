import 'package:dio/dio.dart';

import '../../../../mvs_rest.dart';

abstract class INewsAPI {
  Future<List<NewsDto>> getNews();
}

class NewsAPI implements INewsAPI {
  final IMVSHTTPClient _httpClient;

  NewsAPI({
    required IMVSHTTPClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<NewsDto>> getNews() async {
    final Response response = await this._httpClient.get(
          endpoint: "/items/News",
        );

    final data = response.data['data'] ?? [];

    return List<NewsDto>.from(
      (data as List).map(
        (
          json,
        ) =>
            NewsDto.fromJson(
          json,
        ),
      ),
    );
  }
}
