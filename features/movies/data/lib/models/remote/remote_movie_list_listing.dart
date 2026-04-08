import 'package:movies_domain/domain.dart';

import 'package:movies_data/models/remote/remote_movie_list.dart';

class RemoteMovieListListing {
  final int totalPages;
  final int totalResults;
  final List<RemoteMovieList> lists;

  const RemoteMovieListListing({
    required this.totalPages,
    required this.totalResults,
    required this.lists,
  });

  factory RemoteMovieListListing.fromJson(Map<String, dynamic> json) =>
      RemoteMovieListListing(
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
        lists: (json['results'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(RemoteMovieList.fromJson)
            .toList(),
      );

  MovieListListing toDomain() => MovieListListing(
        totalPages: totalPages,
        totalResults: totalResults,
        lists: lists.map((list) => list.toDomain()).toList(),
      );
}