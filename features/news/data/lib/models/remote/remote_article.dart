import 'package:news_domain/domain.dart';

class RemoteArticle {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String? imageUrl;
  final String sourceUrl;
  final String source;
  final String publishedAt;

  const RemoteArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    this.imageUrl,
    required this.sourceUrl,
    required this.source,
    required this.publishedAt,
  });

  factory RemoteArticle.fromJson(Map<String, dynamic> json) => RemoteArticle(
        id: json['id'] as int,
        title: json['title'] as String,
        summary: json['summary'] as String,
        content: json['content'] as String,
        imageUrl: json['imageUrl'] as String?,
        sourceUrl: json['sourceUrl'] as String,
        source: json['source'] as String,
        publishedAt: json['publishedAt'] as String,
      );

  Article toDomain() => Article(
        id: id,
        title: title,
        summary: summary,
        content: content,
        imageUrl: imageUrl,
        sourceUrl: sourceUrl,
        source: source,
        publishedAt: publishedAt,
      );
}
