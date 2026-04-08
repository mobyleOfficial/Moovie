// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'search_router.dart';

/// generated route for
/// [ReleaseDateDecadesPage]
class ReleaseDateDecadesRoute extends PageRouteInfo<void> {
  const ReleaseDateDecadesRoute({List<PageRouteInfo>? children})
    : super(ReleaseDateDecadesRoute.name, initialChildren: children);

  static const String name = 'ReleaseDateDecadesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReleaseDateDecadesPage();
    },
  );
}

/// generated route for
/// [ReleaseDateMoviesPage]
class ReleaseDateMoviesRoute extends PageRouteInfo<ReleaseDateMoviesRouteArgs> {
  ReleaseDateMoviesRoute({
    Key? key,
    required String title,
    int? primaryReleaseYear,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
    List<PageRouteInfo>? children,
  }) : super(
         ReleaseDateMoviesRoute.name,
         args: ReleaseDateMoviesRouteArgs(
           key: key,
           title: title,
           primaryReleaseYear: primaryReleaseYear,
           releaseDateGte: releaseDateGte,
           releaseDateLte: releaseDateLte,
           sortBy: sortBy,
         ),
         initialChildren: children,
       );

  static const String name = 'ReleaseDateMoviesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReleaseDateMoviesRouteArgs>();
      return ReleaseDateMoviesPage(
        key: args.key,
        title: args.title,
        primaryReleaseYear: args.primaryReleaseYear,
        releaseDateGte: args.releaseDateGte,
        releaseDateLte: args.releaseDateLte,
        sortBy: args.sortBy,
      );
    },
  );
}

class ReleaseDateMoviesRouteArgs {
  const ReleaseDateMoviesRouteArgs({
    this.key,
    required this.title,
    this.primaryReleaseYear,
    this.releaseDateGte,
    this.releaseDateLte,
    this.sortBy,
  });

  final Key? key;

  final String title;

  final int? primaryReleaseYear;

  final String? releaseDateGte;

  final String? releaseDateLte;

  final String? sortBy;

  @override
  String toString() {
    return 'ReleaseDateMoviesRouteArgs{key: $key, title: $title, primaryReleaseYear: $primaryReleaseYear, releaseDateGte: $releaseDateGte, releaseDateLte: $releaseDateLte, sortBy: $sortBy}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReleaseDateMoviesRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        primaryReleaseYear == other.primaryReleaseYear &&
        releaseDateGte == other.releaseDateGte &&
        releaseDateLte == other.releaseDateLte &&
        sortBy == other.sortBy;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      title.hashCode ^
      primaryReleaseYear.hashCode ^
      releaseDateGte.hashCode ^
      releaseDateLte.hashCode ^
      sortBy.hashCode;
}

/// generated route for
/// [ReleaseDateYearsPage]
class ReleaseDateYearsRoute extends PageRouteInfo<ReleaseDateYearsRouteArgs> {
  ReleaseDateYearsRoute({
    Key? key,
    required int decade,
    required String decadeLabel,
    List<PageRouteInfo>? children,
  }) : super(
         ReleaseDateYearsRoute.name,
         args: ReleaseDateYearsRouteArgs(
           key: key,
           decade: decade,
           decadeLabel: decadeLabel,
         ),
         initialChildren: children,
       );

  static const String name = 'ReleaseDateYearsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReleaseDateYearsRouteArgs>();
      return ReleaseDateYearsPage(
        key: args.key,
        decade: args.decade,
        decadeLabel: args.decadeLabel,
      );
    },
  );
}

class ReleaseDateYearsRouteArgs {
  const ReleaseDateYearsRouteArgs({
    this.key,
    required this.decade,
    required this.decadeLabel,
  });

  final Key? key;

  final int decade;

  final String decadeLabel;

  @override
  String toString() {
    return 'ReleaseDateYearsRouteArgs{key: $key, decade: $decade, decadeLabel: $decadeLabel}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReleaseDateYearsRouteArgs) return false;
    return key == other.key &&
        decade == other.decade &&
        decadeLabel == other.decadeLabel;
  }

  @override
  int get hashCode => key.hashCode ^ decade.hashCode ^ decadeLabel.hashCode;
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchPage();
    },
  );
}
