import 'package:core/core.dart';
import 'package:news_domain/models/article_listing.dart';
import 'package:news_domain/repositories/news_repository.dart';

class GetArticles extends UseCase<int, Result<ArticleListing>> {
  final NewsRepository _repository;

  GetArticles(this._repository);

  @override
  Future<Result<ArticleListing>> call([int? params]) async {
    return _repository.getArticles(page: params ?? 1);
  }
}
