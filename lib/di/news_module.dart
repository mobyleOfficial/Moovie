import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:news/news.dart';

@module
abstract class NewsModule {
  @lazySingleton
  NewsRemoteDataSource newsDataSource(
    @Named('backend') HttpClient httpClient,
  ) =>
      NewsRemoteDataSourceImpl(httpClient);

  @lazySingleton
  NewsRepository newsRepository(
    NewsRemoteDataSource remoteDataSource,
  ) =>
      NewsRepositoryImpl(remoteDataSource);

  @injectable
  GetArticles getArticles(NewsRepository repository) =>
      GetArticles(repository);

  @injectable
  GetArticleDetail getArticleDetail(NewsRepository repository) =>
      GetArticleDetail(repository);
}
