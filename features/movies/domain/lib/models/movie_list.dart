class MovieList {
  final int id;
  final String name;
  final String creator;
  final String description;
  final int movieCount;
  final List<String> posterPaths;

  const MovieList({
    required this.id,
    required this.name,
    required this.creator,
    required this.description,
    required this.movieCount,
    required this.posterPaths,
  });
}