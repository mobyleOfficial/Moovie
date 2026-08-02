import 'dart:async';
import 'dart:developer' as dev;

import 'package:core/core.dart';
import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_domain/models/movie_listing.dart';
import 'package:movies_domain/models/movie_review_listing.dart';
import 'package:profile_data/datasources/profile_remote_data_source.dart';
import 'package:profile_domain/models/user_profile.dart';
import 'package:profile_domain/repositories/profile_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final MoviesRemoteDataSource _moviesRemoteDataSource;
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final WebSocketClient _webSocketClient;

  final _profileSubject = BehaviorSubject<UserProfile>();

  ProfileRepositoryImpl(
    this._moviesRemoteDataSource,
    this._profileRemoteDataSource,
    this._webSocketClient,
  ) {
    fetchProfile();
    _listenToWebSocket();
  }

  @override
  Stream<UserProfile> watchProfile() => _profileSubject.stream;

  Future<void> fetchProfile() async {
    final result = await _profileRemoteDataSource.getUserProfile();
    if (result is Success<UserProfile>) {
      _profileSubject.add(result.data);
    }
  }

  @override
  Future<Result<void>> startScrape({
    required String source,
    required String username,
    required String cookies,
  }) async {
    final result = await _profileRemoteDataSource.startScrape(
      source: source,
      username: username,
      cookies: cookies,
    );
    if (result is Success && _profileSubject.hasValue) {
      _profileSubject.add(_profileSubject.value.copyWith(isScraping: true));
    }
    return result;
  }

  void _listenToWebSocket() {
    _webSocketClient.messages.listen(
      (message) {
        dev.log('[ProfileRepo] WS message received: ${message.type}');
        _handleWsMessage(message);
      },
      onError: (e) {
        dev.log('[ProfileRepo] WS stream error: $e');
      },
    );
  }

  void _handleWsMessage(WsMessage message) {
    switch (message.type) {
      case WsMessageType.scrapeStarted:
        dev.log('[ProfileRepo] Scrape started');
        if (_profileSubject.hasValue) {
          _profileSubject
              .add(_profileSubject.value.copyWith(isScraping: true));
        }
      case WsMessageType.scrapeFinished:
        dev.log('[ProfileRepo] Scrape finished, refreshing profile');
        if (_profileSubject.hasValue) {
          _profileSubject.add(_profileSubject.value.copyWith(isScraping: false));
        }
      default:
    }
  }

  @override
  Future<Result<MovieReviewListing>> getUserReviews({required int page}) async {
    final result = await _moviesRemoteDataSource.getMovieReviews(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<MovieListing>> getUserFavoriteMovies({
    required String userId,
    required int page,
  }) async {
    final result = await _moviesRemoteDataSource.getUserFavoriteMovies(
      userId: userId,
      page: page,
    );

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<void>> updateUserProfile({
    required UserProfile profile,
  }) async => _profileRemoteDataSource.updateUserProfile(profile: profile);
}
