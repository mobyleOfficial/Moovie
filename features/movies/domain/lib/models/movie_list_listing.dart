import 'package:movies_domain/models/movie_list.dart';

class MovieListListing {
  final int totalPages;
  final int totalResults;
  final List<MovieList> lists;

  const MovieListListing({
    required this.totalPages,
    required this.totalResults,
    required this.lists,
  });
}