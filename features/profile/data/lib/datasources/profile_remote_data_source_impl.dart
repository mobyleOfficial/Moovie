import 'package:core/core.dart';
import 'package:movies_domain/domain.dart';
import 'package:profile_data/datasources/profile_remote_data_source.dart';
import 'package:profile_domain/models/user_profile.dart';
import 'package:profile_domain/models/user_summary.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  // ignore: unused_field
  final HttpClient _httpClient;

  ProfileRemoteDataSourceImpl(this._httpClient);

  @override
  Future<Result<void>> updateUserProfile({
    required UserProfile profile,
  }) async =>
      const Success(null);

  @override
  Future<Result<UserProfile>> getUserProfile() async => const Success(
        UserProfile(
          photoUrl: '',
          username: '@filmfan42',
          bio: 'Movie lover & critic',
          moviesWatched: _mockedMoviesWatched,
          following: _mockedFollowing,
          followers: _mockedFollowers,
        ),
      );
}

const _mockedMoviesWatched = <Movie>[
  Movie(id: 693134, title: 'Dune: Part Two', posterPath: '/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 8.2, releaseDate: '2024-02-27')),
  Movie(id: 872585, title: 'Oppenheimer', posterPath: '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 8.1, releaseDate: '2023-07-19')),
  Movie(id: 792307, title: 'Poor Things', posterPath: '/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 7.9, releaseDate: '2023-12-07')),
  Movie(id: 929590, title: 'The Zone of Interest', posterPath: '/hUu9zyZmDd8VZegKi1iK1Vk0RYS.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 7.2, releaseDate: '2023-12-15')),
  Movie(id: 876969, title: 'Society of the Snow', posterPath: '/2e853FDVSIso600RqAMunPxiZjq.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 7.9, releaseDate: '2023-12-13')),
  Movie(id: 872906, title: 'The Holdovers', posterPath: '/VCL6JEvXqR4n3OYejaOnOL2xsm.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 7.8, releaseDate: '2023-10-27')),
  Movie(id: 507089, title: 'Five Nights at Freddy\'s', posterPath: '/3uawmPVd8Ws7hOXbFpnTpvbsvV7.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 7.7, releaseDate: '2023-10-25')),
  Movie(id: 1029575, title: 'The Family Plan', posterPath: '/ih3aZ6oTkRt4hMzZDZzyl2iQxsE.jpg', info: MovieInfo(overview: '', backdropPath: '', voteAverage: 7.5, releaseDate: '2023-12-15')),
];

const _mockedFollowing = <UserSummary>[
  UserSummary(id: 'u-alice', username: '@alice', photoUrl: ''),
  UserSummary(id: 'u-bruno', username: '@bruno_c', photoUrl: ''),
  UserSummary(id: 'u-carla', username: '@carla.films', photoUrl: ''),
  UserSummary(id: 'u-diego', username: '@diego_r', photoUrl: ''),
  UserSummary(id: 'u-elena', username: '@elena.cine', photoUrl: ''),
  UserSummary(id: 'u-felipe', username: '@felipe.m', photoUrl: ''),
];

const _mockedFollowers = <UserSummary>[
  UserSummary(id: 'u-gina', username: '@gina_g', photoUrl: ''),
  UserSummary(id: 'u-hugo', username: '@hugo.reviews', photoUrl: ''),
  UserSummary(id: 'u-isabel', username: '@isabel.p', photoUrl: ''),
  UserSummary(id: 'u-joao', username: '@joao_s', photoUrl: ''),
  UserSummary(id: 'u-karla', username: '@karla.k', photoUrl: ''),
  UserSummary(id: 'u-leo', username: '@leo.screen', photoUrl: ''),
  UserSummary(id: 'u-maria', username: '@maria_m', photoUrl: ''),
  UserSummary(id: 'u-nuno', username: '@nuno.n', photoUrl: ''),
  UserSummary(id: 'u-olivia', username: '@olivia.o', photoUrl: ''),
];
