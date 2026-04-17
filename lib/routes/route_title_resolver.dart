import 'package:auto_route/auto_route.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_router.dart';
import 'package:public_profile/public_profile_router.dart';
import 'package:reviews/review_details/review_details_router.dart';
import 'package:reviews/reviews_list/reviews_router.dart';
import 'package:search/search_router.dart';

String? resolveRouteTitle(RouteData<dynamic> routeData) => switch (routeData.name) {
      ReviewsRoute.name => () {
        final args = routeData.argsAs<ReviewsRouteArgs>(orElse: () => const ReviewsRouteArgs());
        final title = args.movieTitle;
        return title != null ? '$title Reviews' : 'Reviews';
      }(),
      ReviewDetailsRoute.name => routeData.argsAs<ReviewDetailsRouteArgs>().movieTitle,
      MovieDetailRoute.name => routeData.argsAs<MovieDetailRouteArgs>().movieTitle,
      MovieListDetailRoute.name => routeData.argsAs<MovieListDetailRouteArgs>().listName,
      PublicProfileRoute.name => routeData.argsAs<PublicProfileRouteArgs>().userId,
      ReleaseDateDecadesRoute.name => 'Release Date',
      ReleaseDateYearsRoute.name => routeData.argsAs<ReleaseDateYearsRouteArgs>().decadeLabel,
      ReleaseDateMoviesRoute.name => routeData.argsAs<ReleaseDateMoviesRouteArgs>().title,
      BrowseCategoriesRoute.name => 'Browse',
      MostPopularRoute.name => 'Most Popular',
      HighestRatedRoute.name => 'Highest Rated',
      MostAnticipatedRoute.name => 'Most Anticipated',
      FeaturedListsRoute.name => 'Featured Lists',
      _ => null,
    };
