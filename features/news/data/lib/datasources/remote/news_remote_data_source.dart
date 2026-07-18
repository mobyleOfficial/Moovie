import 'package:core/core.dart';
import 'package:news_data/models/remote/remote_article.dart';
import 'package:news_data/models/remote/remote_article_listing.dart';

abstract interface class NewsRemoteDataSource {
  Future<Result<RemoteArticleListing>> getArticles({required int page});
  Future<Result<RemoteArticle>> getArticleDetail({required int articleId});
}
