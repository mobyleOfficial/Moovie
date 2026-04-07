// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'movie_list_detail_router.dart';

/// generated route for
/// [MovieListDetailPage]
class MovieListDetailRoute extends PageRouteInfo<MovieListDetailRouteArgs> {
  MovieListDetailRoute({
    Key? key,
    required int listId,
    required String listName,
    required List<String> posterPaths,
    List<PageRouteInfo>? children,
  }) : super(
         MovieListDetailRoute.name,
         args: MovieListDetailRouteArgs(
           key: key,
           listId: listId,
           listName: listName,
           posterPaths: posterPaths,
         ),
         initialChildren: children,
       );

  static const String name = 'MovieListDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieListDetailRouteArgs>();
      return MovieListDetailPage(
        key: args.key,
        listId: args.listId,
        listName: args.listName,
        posterPaths: args.posterPaths,
      );
    },
  );
}

class MovieListDetailRouteArgs {
  const MovieListDetailRouteArgs({
    this.key,
    required this.listId,
    required this.listName,
    required this.posterPaths,
  });

  final Key? key;

  final int listId;

  final String listName;

  final List<String> posterPaths;

  @override
  String toString() {
    return 'MovieListDetailRouteArgs{key: $key, listId: $listId, listName: $listName, posterPaths: $posterPaths}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieListDetailRouteArgs) return false;
    return key == other.key &&
        listId == other.listId &&
        listName == other.listName &&
        const ListEquality<String>().equals(posterPaths, other.posterPaths);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      listId.hashCode ^
      listName.hashCode ^
      const ListEquality<String>().hash(posterPaths);
}
