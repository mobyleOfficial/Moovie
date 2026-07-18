import 'package:injectable/injectable.dart';
import 'package:news_domain/domain.dart';

@module
abstract class NewsDiModule {
  @injectable
  GetArticles getArticles(NewsRepository newsRepository) =>
      GetArticles(newsRepository);

  @injectable
  GetArticleDetail getArticleDetail(NewsRepository newsRepository) =>
      GetArticleDetail(newsRepository);
}
