class Article {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String? imageUrl;
  final String sourceUrl;
  final String source;
  final String publishedAt;

  const Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    this.imageUrl,
    required this.sourceUrl,
    required this.source,
    required this.publishedAt,
  });
}
