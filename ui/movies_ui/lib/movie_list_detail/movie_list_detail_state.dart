import 'package:movies/movies.dart';

sealed class MovieListDetailState {
  const MovieListDetailState();
}

class MovieListDetailLoading extends MovieListDetailState {
  const MovieListDetailLoading();
}

class MovieListDetailSuccess extends MovieListDetailState {
  final MovieList detail;
  final bool isLiked;
  final int likesCount;
  final bool isGridView;

  const MovieListDetailSuccess({
    required this.detail,
    required this.isLiked,
    required this.likesCount,
    this.isGridView = true,
  });

  MovieListDetailSuccess copyWith({
    MovieList? detail,
    bool? isLiked,
    int? likesCount,
    bool? isGridView,
  }) =>
      MovieListDetailSuccess(
        detail: detail ?? this.detail,
        isLiked: isLiked ?? this.isLiked,
        likesCount: likesCount ?? this.likesCount,
        isGridView: isGridView ?? this.isGridView,
      );
}

class MovieListDetailError extends MovieListDetailState {
  final String message;

  const MovieListDetailError(this.message);
}