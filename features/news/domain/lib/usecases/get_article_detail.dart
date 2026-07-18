import 'package:core/core.dart';
import 'package:news_domain/models/article.dart';
import 'package:news_domain/repositories/news_repository.dart';

class GetArticleDetail extends UseCase<int, Result<Article>> {
  final NewsRepository _repository;

  GetArticleDetail(this._repository);

  @override
  Future<Result<Article>> call([int? params]) async {
    return _repository.getArticleDetail(articleId: params ?? 0);
  }
}
