import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:news_domain/domain.dart';

import 'package:news_data/datasources/remote/news_remote_data_source.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _dataSource;

  NewsRepositoryImpl(this._dataSource);

  @override
  Future<Result<ArticleListing>> getArticles({required int page}) async {
    final result = await _dataSource.getArticles(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<Article>> getArticleDetail({required int articleId}) async {
    final result = await _dataSource.getArticleDetail(articleId: articleId);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }
}
