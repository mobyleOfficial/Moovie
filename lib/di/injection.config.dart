// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:core/core.dart' as _i494;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:moovie/di/http_di_module.dart' as _i649;
import 'package:moovie/di/movies_module.dart' as _i993;
import 'package:moovie/di/profile_module.dart' as _i510;
import 'package:moovie/di/public_profile_module.dart' as _i497;
import 'package:moovie/di/user_activities_module.dart' as _i1017;
import 'package:movies/movies.dart' as _i987;
import 'package:profile/profile.dart' as _i16;
import 'package:public_profile_feature/public_profile_feature.dart' as _i805;
import 'package:user_activities/user_activities.dart' as _i824;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final httpDiModule = _$HttpDiModule();
    final moviesModule = _$MoviesModule();
    final userActivitiesModule = _$UserActivitiesModule();
    final profileModule = _$ProfileModule();
    final publicProfileModule = _$PublicProfileModule();
    gh.singleton<_i494.LocalClient>(() => httpDiModule.localClient);
    gh.singleton<_i361.Dio>(
      () => httpDiModule.backendDio,
      instanceName: 'backend',
    );
    gh.singleton<_i361.Dio>(() => httpDiModule.tmdbDio, instanceName: 'tmdb');
    gh.lazySingleton<_i987.MoviesLocalDataSource>(
      () => moviesModule.moviesLocalDataSource(
        gh<_i987.Store>(),
        gh<_i494.LocalClient>(),
      ),
    );
    gh.lazySingleton<_i824.UserActivitiesLocalDataSource>(
      () => userActivitiesModule.userActivitiesLocalDataSource(
        gh<_i987.Store>(),
        gh<_i494.LocalClient>(),
      ),
    );
    gh.singleton<_i494.HttpClient>(
      () => httpDiModule.backendClient(gh<_i361.Dio>(instanceName: 'backend')),
      instanceName: 'backend',
    );
    gh.singleton<_i494.HttpClient>(
      () => httpDiModule.tmdbClient(gh<_i361.Dio>(instanceName: 'tmdb')),
      instanceName: 'tmdb',
    );
    gh.lazySingleton<_i987.MoviesRemoteDataSource>(
      () => moviesModule.moviesDataSource(
        gh<_i494.HttpClient>(instanceName: 'tmdb'),
      ),
    );
    gh.lazySingleton<_i16.ProfileRemoteDataSource>(
      () => profileModule.profileRemoteDataSource(
        gh<_i494.HttpClient>(instanceName: 'tmdb'),
      ),
    );
    gh.lazySingleton<_i805.PublicProfileRemoteDataSource>(
      () => publicProfileModule.publicProfileRemoteDataSource(
        gh<_i494.HttpClient>(instanceName: 'tmdb'),
      ),
    );
    gh.lazySingleton<_i824.UserActivitiesRemoteDataSource>(
      () => userActivitiesModule.userActivitiesRemoteDataSource(
        gh<_i494.HttpClient>(instanceName: 'tmdb'),
      ),
    );
    gh.lazySingleton<_i16.ProfileRepository>(
      () => profileModule.profileRepository(
        gh<_i987.MoviesRemoteDataSource>(),
        gh<_i16.ProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i16.GetUserReviews>(
      () => profileModule.getUserReviews(gh<_i16.ProfileRepository>()),
    );
    gh.factory<_i16.GetUserFavoriteMovies>(
      () => profileModule.getUserFavoriteMovies(gh<_i16.ProfileRepository>()),
    );
    gh.factory<_i16.UpdateUserProfile>(
      () => profileModule.updateUserProfile(gh<_i16.ProfileRepository>()),
    );
    gh.factory<_i16.GetUserProfile>(
      () => profileModule.getUserProfile(gh<_i16.ProfileRepository>()),
    );
    gh.lazySingleton<_i987.MoviesRepository>(
      () => moviesModule.moviesRepository(
        gh<_i987.MoviesRemoteDataSource>(),
        gh<_i987.MoviesLocalDataSource>(),
      ),
    );
    gh.factory<_i987.GetTrendingMovies>(
      () => moviesModule.getTrendingMovies(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetMovieDetail>(
      () => moviesModule.getMovieDetail(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetMovieReviews>(
      () => moviesModule.getMovieReviews(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetMovieLists>(
      () => moviesModule.getMovieLists(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetUserMovieLists>(
      () => moviesModule.getUserMovieLists(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetMovieListDetail>(
      () => moviesModule.getMovieListDetail(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.DiscoverMovies>(
      () => moviesModule.discoverMovies(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetGenres>(
      () => moviesModule.getGenres(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetCountries>(
      () => moviesModule.getCountries(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetLanguages>(
      () => moviesModule.getLanguages(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.SearchMovies>(
      () => moviesModule.searchMovies(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.AddRecentSearch>(
      () => moviesModule.addRecentSearch(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.ObserveRecentSearches>(
      () => moviesModule.observeRecentSearches(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetUserWatchList>(
      () => moviesModule.getUserWatchList(gh<_i987.MoviesRepository>()),
    );
    gh.factory<_i987.GetFeaturedLists>(
      () => moviesModule.getFeaturedLists(gh<_i987.MoviesRepository>()),
    );
    gh.lazySingleton<_i805.PublicProfileRepository>(
      () => publicProfileModule.publicProfileRepository(
        gh<_i805.PublicProfileRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i824.UserActivitiesRepository>(
      () => userActivitiesModule.userActivitiesRepository(
        gh<_i824.UserActivitiesRemoteDataSource>(),
        gh<_i824.UserActivitiesLocalDataSource>(),
      ),
    );
    gh.factory<_i824.GetUserActivities>(
      () => userActivitiesModule.getUserActivities(
        gh<_i824.UserActivitiesRepository>(),
      ),
    );
    gh.factory<_i824.UpsertMovieReview>(
      () => userActivitiesModule.upsertMovieReview(
        gh<_i824.UserActivitiesRepository>(),
      ),
    );
    gh.factory<_i824.ObserveMovieReviewDraftsList>(
      () => userActivitiesModule.observeMovieReviewDraftsList(
        gh<_i824.UserActivitiesRepository>(),
      ),
    );
    gh.factory<_i824.DeleteDraft>(
      () => userActivitiesModule.deleteDraft(
        gh<_i824.UserActivitiesRepository>(),
      ),
    );
    gh.factory<_i824.GetFriendsActivities>(
      () => userActivitiesModule.getFriendsActivities(
        gh<_i824.UserActivitiesRepository>(),
      ),
    );
    gh.factory<_i805.GetPublicProfile>(
      () => publicProfileModule.getPublicProfile(
        gh<_i805.PublicProfileRepository>(),
      ),
    );
    return this;
  }
}

class _$HttpDiModule extends _i649.HttpDiModule {}

class _$MoviesModule extends _i993.MoviesModule {}

class _$UserActivitiesModule extends _i1017.UserActivitiesModule {}

class _$ProfileModule extends _i510.ProfileModule {}

class _$PublicProfileModule extends _i497.PublicProfileModule {}
