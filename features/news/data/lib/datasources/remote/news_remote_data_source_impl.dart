import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:news_data/models/remote/remote_article.dart';
import 'package:news_data/models/remote/remote_article_listing.dart';

import 'news_remote_data_source.dart';

@injectable
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final HttpClient _httpClient;

  NewsRemoteDataSourceImpl(@Named('backend') this._httpClient);

  @override
  Future<Result<RemoteArticleListing>> getArticles({
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      '/articles',
      queryParams: {'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteArticleListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteArticle>> getArticleDetail({
    required int articleId,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      '/articles/$articleId',
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteArticle.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }
}
