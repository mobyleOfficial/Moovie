import 'package:news_domain/models/article.dart';

sealed class ArticleDetailState {
  const ArticleDetailState();
}

class ArticleDetailLoading extends ArticleDetailState {
  const ArticleDetailLoading();
}

class ArticleDetailSuccess extends ArticleDetailState {
  final Article article;

  const ArticleDetailSuccess(this.article);
}

class ArticleDetailError extends ArticleDetailState {
  final String message;

  const ArticleDetailError(this.message);
}
