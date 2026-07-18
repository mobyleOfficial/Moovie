import 'package:news_domain/domain.dart';

import 'package:news_data/models/remote/remote_article.dart';

class RemoteArticleListing {
  final int totalPages;
  final int totalResults;
  final int page;
  final List<RemoteArticle> articles;

  const RemoteArticleListing({
    required this.totalPages,
    required this.totalResults,
    required this.page,
    required this.articles,
  });

  factory RemoteArticleListing.fromJson(Map<String, dynamic> json) =>
      RemoteArticleListing(
        totalPages: json['totalPages'] as int,
        totalResults: json['totalResults'] as int,
        page: json['page'] as int,
        articles: (json['articles'] as List<dynamic>)
            .map((e) => RemoteArticle.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  ArticleListing toDomain() => ArticleListing(
        totalPages: totalPages,
        totalResults: totalResults,
        page: page,
        articles: articles.map((e) => e.toDomain()).toList(),
      );
}
