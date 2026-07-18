import 'package:news_domain/models/article.dart';

class ArticleListing {
  final int totalPages;
  final int totalResults;
  final int page;
  final List<Article> articles;

  const ArticleListing({
    required this.totalPages,
    required this.totalResults,
    required this.page,
    required this.articles,
  });
}
