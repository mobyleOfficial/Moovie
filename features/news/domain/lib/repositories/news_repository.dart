import 'package:core/core.dart';
import 'package:news_domain/models/article.dart';
import 'package:news_domain/models/article_listing.dart';

abstract interface class NewsRepository {
  Future<Result<ArticleListing>> getArticles({required int page});
  Future<Result<Article>> getArticleDetail({required int articleId});
}
