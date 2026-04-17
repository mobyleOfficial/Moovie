import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_data/models/remote/remote_movie.dart';
import 'package:movies_data/models/remote/remote_movie_list.dart';
import 'package:movies_data/models/remote/remote_movie_list_detail.dart';
import 'package:movies_data/models/remote/remote_movie_list_listing.dart';
import 'package:movies_data/models/remote/remote_movie_detail.dart';
import 'package:movies_data/models/remote/remote_movie_review.dart';
import 'package:movies_data/models/remote/remote_movie_review_listing.dart';
import 'package:movies_data/models/remote/remote_country.dart';
import 'package:movies_data/models/remote/remote_genre.dart';
import 'package:movies_data/models/remote/remote_language.dart';
import 'package:movies_data/models/remote/remote_movie_listing.dart';

@injectable
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpClient _httpClient;

  MoviesRemoteDataSourceImpl(@Named('tmdb') this._httpClient);

  static const _mockedReviews = [
    RemoteMovieReview(id: 693134, title: 'Dune: Part Two', date: 'Mar 15, 2024', rating: 4.5),
    RemoteMovieReview(id: 872585, title: 'Oppenheimer', date: 'Mar 10, 2024', rating: 5.0),
    RemoteMovieReview(id: 792307, title: 'Poor Things', date: 'Mar 5, 2024', rating: 4.0),
    RemoteMovieReview(id: 929590, title: 'The Zone of Interest', date: 'Feb 28, 2024', rating: 3.5),
    RemoteMovieReview(id: 876969, title: 'Society of the Snow', date: 'Feb 20, 2024', rating: 4.0),
    RemoteMovieReview(id: 976573, title: 'Past Lives', date: 'Feb 14, 2024', rating: 4.5),
    RemoteMovieReview(id: 913209, title: 'Anatomy of a Fall', date: 'Feb 10, 2024', rating: 4.0),
    RemoteMovieReview(id: 840430, title: 'The Holdovers', date: 'Feb 5, 2024', rating: 4.5),
    RemoteMovieReview(id: 346698, title: 'Barbie', date: 'Jan 28, 2024', rating: 3.5),
    RemoteMovieReview(id: 507089, title: 'Five Nights at Freddy\'s', date: 'Jan 20, 2024', rating: 3.0),
    RemoteMovieReview(id: 609681, title: 'The Beekeeper', date: 'Jan 15, 2024', rating: 3.5),
    RemoteMovieReview(id: 940551, title: 'Migration', date: 'Jan 10, 2024', rating: 4.0),
    RemoteMovieReview(id: 866398, title: 'The Brutalist', date: 'Jan 5, 2024', rating: 4.5),
    RemoteMovieReview(id: 1064028, title: 'Anora', date: 'Dec 28, 2023', rating: 5.0),
    RemoteMovieReview(id: 558449, title: 'Animal', date: 'Dec 20, 2023', rating: 3.0),
    RemoteMovieReview(id: 753342, title: 'Napoleon', date: 'Dec 15, 2023', rating: 3.5),
  ];

static const _mockedLists = [
    RemoteMovieList(
      id: 1,
      name: 'Weekend Watchlist',
      creator: 'Sarah Chen',
      description: 'Perfect movies for a lazy weekend. A curated selection of feel-good films, cozy dramas, and light-hearted comedies that pair perfectly with a blanket and some popcorn. Whether you are looking for something to watch solo or with the whole family, this list has you covered with titles that range from critically acclaimed indie gems to crowd-pleasing blockbusters. Grab your favorite snacks, dim the lights, and let these stories transport you somewhere wonderful without ever leaving your couch.',
      movieCount: 12,
      posterPaths: ['/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg', '/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', '/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg'],
    ),
    RemoteMovieList(
      id: 2,
      name: 'Mind-Bending Thrillers',
      creator: 'Jake Morrison',
      description: 'Films that will keep you guessing until the very last frame. From psychological twists to reality-warping narratives, these movies demand your full attention. Every entry on this list was chosen because it does something unexpected with the thriller genre — whether it is an unreliable narrator, a time-loop puzzle, or a slow-burn mystery that completely recontextualizes everything you thought you knew. Perfect for viewers who love dissecting plot details and rewatching scenes to catch hidden clues they missed the first time around.',
      movieCount: 18,
      posterPaths: ['/53YWSo75mSaw1vd2YEeX5kwkRos.jpg', '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', '/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg', '/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg'],
    ),
    RemoteMovieList(
      id: 3,
      name: 'Feel-Good Classics',
      creator: 'Emma Wright',
      description: 'Guaranteed to brighten your day. Timeless films that never fail to put a smile on your face, from beloved rom-coms to heartwarming family favorites.',
      movieCount: 24,
      posterPaths: ['/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg', '/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg', '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/53YWSo75mSaw1vd2YEeX5kwkRos.jpg'],
    ),
    RemoteMovieList(
      id: 4,
      name: 'Foreign Language Gems',
      creator: 'Luca Rossi',
      description: 'The best of world cinema. Explore extraordinary stories from every corner of the globe — from Korean thrillers to French dramas to Japanese animation. This collection celebrates the incredible diversity of international filmmaking, featuring works that have won top prizes at Cannes, Venice, Berlin, and beyond. Each film offers a window into a different culture and storytelling tradition, proving that great cinema transcends language barriers. Subtitles included, of course, because as Bong Joon-ho once said, once you overcome the one-inch-tall barrier of subtitles, you will be introduced to so many more amazing films.',
      movieCount: 15,
      posterPaths: ['/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', '/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg', '/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg'],
    ),
    RemoteMovieList(
      id: 5,
      name: 'Director\'s Cut',
      creator: 'Mia Tanaka',
      description: 'Essential films from legendary directors. A journey through the filmographies of cinema\'s greatest visionaries, from Kubrick to Villeneuve. This list spans decades of filmmaking excellence, highlighting the defining works of auteurs who shaped the language of cinema itself. You will find everything from Hitchcock\'s masterful suspense to Scorsese\'s gritty character studies, from Spielberg\'s sense of wonder to Nolan\'s architectural storytelling. Each film is not just entertainment but a masterclass in the craft of directing.',
      movieCount: 30,
      posterPaths: ['/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg', '/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', '/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg'],
    ),
    RemoteMovieList(
      id: 6,
      name: 'Underrated 2024',
      creator: 'Noah Kim',
      description: 'Great films you might have missed this year. Hidden treasures that flew under the radar but deserve your attention.',
      movieCount: 10,
      posterPaths: ['/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg', '/53YWSo75mSaw1vd2YEeX5kwkRos.jpg', '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', '/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg'],
    ),
    RemoteMovieList(
      id: 7,
      name: 'Sci-Fi Essentials',
      creator: 'Alex Rivera',
      description: 'Must-watch science fiction from across the decades. From space operas to dystopian futures, these films explore what it means to be human. This collection traces the evolution of the genre from the golden age of practical effects to the modern era of photorealistic CGI, but what ties every entry together is the power of ideas. Whether it is a quiet contemplation of artificial intelligence, a sprawling interstellar adventure, or a claustrophobic survival horror set on a derelict spaceship, each film uses speculative premises to ask profound questions about identity, technology, and our place in the universe.',
      movieCount: 22,
      posterPaths: ['/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg', '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg', '/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg'],
    ),
    RemoteMovieList(
      id: 8,
      name: 'Date Night Picks',
      creator: 'Olivia Hart',
      description: 'Romantic and fun movies for two. Whether you\'re in the mood for a sweeping romance or a quirky comedy, these films set the perfect tone.',
      movieCount: 16,
      posterPaths: ['/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', '/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg', '/53YWSo75mSaw1vd2YEeX5kwkRos.jpg'],
    ),
    RemoteMovieList(
      id: 9,
      name: 'Comfort Rewatches',
      creator: 'Ben Torres',
      description: 'Movies worth watching again and again. The cinematic equivalent of comfort food — films you return to like old friends. There is something deeply satisfying about revisiting a movie you already love: you notice new details in the cinematography, catch subtle foreshadowing you missed before, and rediscover why certain scenes moved you in the first place. This list is full of films that reward repeat viewings, from endlessly quotable comedies to epic adventures that feel just as thrilling the tenth time around.',
      movieCount: 20,
      posterPaths: ['/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg', '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', '/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg', '/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg', '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg'],
    ),
    RemoteMovieList(
      id: 10,
      name: 'Award Season Contenders',
      creator: 'Priya Sharma',
      description: 'This year\'s Oscar hopefuls. The most talked-about performances, directing achievements, and screenplays competing for gold.',
      movieCount: 14,
      posterPaths: ['/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg', '/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg', '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg'],
    ),
  ];

  static const _mockedListMovies = [
    RemoteMovie(id: 693134, title: 'Dune: Part Two', overview: 'Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen.', posterPath: '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg', backdropPath: '/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg', voteAverage: 8.2, releaseDate: '2024-02-27'),
    RemoteMovie(id: 872585, title: 'Oppenheimer', overview: 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.', posterPath: '/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg', backdropPath: '/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg', voteAverage: 8.1, releaseDate: '2023-07-19'),
    RemoteMovie(id: 792307, title: 'Poor Things', overview: 'Brought back to life by an unorthodox scientist, a young woman runs off with a debauched lawyer.', posterPath: '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', backdropPath: '/bQS43HSLZzMjZkcHJz4fGc9fgrt.jpg', voteAverage: 7.9, releaseDate: '2023-12-07'),
    RemoteMovie(id: 467244, title: 'The Zone of Interest', overview: 'The commandant of Auschwitz and his wife strive to build a dream life beside the camp.', posterPath: '/iQoyDhBjHwo1HTR0DuTzR8o1CqI.jpg', backdropPath: '/geLtY6DGe2d7wkNYfsDhMGSlVQ2.jpg', voteAverage: 7.4, releaseDate: '2023-12-15'),
    RemoteMovie(id: 976573, title: 'Past Lives', overview: 'Two childhood friends are reunited in New York after decades apart.', posterPath: '/tsfaRkZfUl5Ve9GMV8oY0UuLH52.jpg', backdropPath: '/5wDLhJp4oIwwLDxewlMQXpZ3Mfd.jpg', voteAverage: 7.8, releaseDate: '2023-06-02'),
    RemoteMovie(id: 840430, title: 'The Holdovers', overview: 'A curmudgeonly instructor at a prep school is forced to babysit a student over Christmas break.', posterPath: '/ek4FmIkKlH30xthKs2ANqrV7SOI.jpg', backdropPath: '/rz8GGX5Id2hCW1PzgCY8HNONnBl.jpg', voteAverage: 7.9, releaseDate: '2023-10-27'),
    RemoteMovie(id: 346698, title: 'Barbie', overview: 'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land.', posterPath: '/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg', backdropPath: '/nHf61UzkfFno5X1ofIhugCPus2R.jpg', voteAverage: 7.0, releaseDate: '2023-07-19'),
    RemoteMovie(id: 1064213, title: 'The Brutalist', overview: 'A visionary architect escapes the horrors of post-war Europe for the promise of America.', posterPath: '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', backdropPath: '/6DYFBb8Rf3Z7OqBCqtdzgFbEpxR.jpg', voteAverage: 7.6, releaseDate: '2024-12-20'),
    RemoteMovie(id: 1064028, title: 'Anora', overview: 'A young sex worker from Brooklyn gets her chance at a Cinderella story.', posterPath: '/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', backdropPath: '/4cp40IyTpFfsT2IKpl0YlUkMBIR.jpg', voteAverage: 7.5, releaseDate: '2024-10-18'),
    RemoteMovie(id: 913209, title: 'Anatomy of a Fall', overview: 'A woman is suspected of her husband\'s murder, and their blind son faces a moral dilemma.', posterPath: '/AsEc6EPLtKKAH1JogIczK8QSPLW.jpg', backdropPath: '/7uv7PsMbSEgTBkYQce9N0m2Gsps.jpg', voteAverage: 7.7, releaseDate: '2023-08-23'),
    RemoteMovie(id: 507089, title: 'Five Nights at Freddy\'s', overview: 'A troubled security guard begins working at Freddy Fazbear\'s Pizza.', posterPath: '/1yUbmAiw2cUSpyXNIaiST7JzCtG.jpg', backdropPath: '/t5zCBSB5xMDKcDqe91qahCOUYVV.jpg', voteAverage: 7.0, releaseDate: '2023-10-25'),
    RemoteMovie(id: 866398, title: 'The Beekeeper', overview: 'One man\'s brutal campaign for vengeance takes on national stakes.', posterPath: '/raNfPn7DGbh1Ffwq4Y9BO1Iektv.jpg', backdropPath: '/cedbbhXosPuEfkrq8cjWcnKFnjK.jpg', voteAverage: 7.1, releaseDate: '2024-01-08'),
    RemoteMovie(id: 940551, title: 'Migration', overview: 'A family of ducks try to convince their overprotective father to go on the vacation of a lifetime.', posterPath: '/wXWnUhdnSuADRp9w7aAZNHx682v.jpg', backdropPath: '/2KGxQFV9Wp1MshPBf8BuqWUgVAz.jpg', voteAverage: 7.4, releaseDate: '2023-12-22'),
    RemoteMovie(id: 753342, title: 'Napoleon', overview: 'An epic that details the checkered rise and fall of French Emperor Napoleon Bonaparte.', posterPath: '/2UY2xfkgw9EgOOyA7ro3eyGJ9V9.jpg', backdropPath: '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg', voteAverage: 6.5, releaseDate: '2023-11-22'),
    RemoteMovie(id: 848538, title: 'Argylle', overview: 'When the plots of a spy novelist begin to mirror real-life events, she is thrust into the world of espionage.', posterPath: '/1ojCiMpYmCciIFuEcgLOOGLbUND.jpg', backdropPath: '/6lE2e6j8qbtQR8aHxQNJlUxpGGO.jpg', voteAverage: 6.1, releaseDate: '2024-01-31'),
    RemoteMovie(id: 763215, title: 'Damsel', overview: 'A young woman agrees to marry a prince, only to discover that the royal family has recruited her as a sacrifice.', posterPath: '/ub4EHdVBVm3nHJiamU0gGcKS4ae.jpg', backdropPath: '/hzxGaOap8Kz3wLDqzVsVPT50yAw.jpg', voteAverage: 7.1, releaseDate: '2024-03-08'),
    RemoteMovie(id: 634492, title: 'Madame Web', overview: 'Cassandra Webb develops the power to see the future and must protect three young women from a deadly threat.', posterPath: '/zWEm5oy2tE9ku1KSNM089FmZJ2p.jpg', backdropPath: '/4woSOUD0equAYzvwhWBHIJDCM88.jpg', voteAverage: 5.6, releaseDate: '2024-02-14'),
    RemoteMovie(id: 1011985, title: 'Kung Fu Panda 4', overview: 'Po must train a new warrior when he is chosen to become the Spiritual Leader of the Valley of Peace.', posterPath: '/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg', backdropPath: '/hF8MqFJ9eTRFRkJFqpjhgqPsCeC.jpg', voteAverage: 7.0, releaseDate: '2024-03-08'),
    RemoteMovie(id: 823464, title: 'Godzilla x Kong: The New Empire', overview: 'Two ancient titans, Godzilla and Kong, clash in an epic battle as humans unravel their origins.', posterPath: '/fWSGD2yrzz6hscocnMD8AEXIThk.jpg', backdropPath: '/xRd1eJIDe7JHO5u4gtEYwGn5wtf.jpg', voteAverage: 7.2, releaseDate: '2024-03-27'),
    RemoteMovie(id: 929590, title: 'Civil War', overview: 'A journey across a dystopian future America following a team of military-embedded journalists.', posterPath: '/fIEjqQnnkxwUH102XU9R3QwRGEu.jpg', backdropPath: '/z121dSTR7PY9KxKuvwiIFSYW8cf.jpg', voteAverage: 7.0, releaseDate: '2024-04-11'),
    RemoteMovie(id: 1096197, title: 'No Way Up', overview: 'Characters trapped in an underwater plane wreckage must fight for survival as sharks close in.', posterPath: '/iJgY7pFXAs2PKhoA1g9jeoqUmQd.jpg', backdropPath: '/4woSOUD0equAYzvwhWBHIJDCM88.jpg', voteAverage: 6.3, releaseDate: '2024-01-18'),
    RemoteMovie(id: 786892, title: 'Furiosa: A Mad Max Saga', overview: 'The origin story of the mighty warrior Furiosa before she joined forces with Mad Max.', posterPath: '/7qOSKoOAPgemYhBwbJgBWcCxPWZ.jpg', backdropPath: '/shrwC6U8Bkst9V9IKPmGMof8aS5.jpg', voteAverage: 7.6, releaseDate: '2024-05-22'),
    RemoteMovie(id: 1022789, title: 'Inside Out 2', overview: 'A new set of emotions join Riley\'s mind as she enters her teenage years.', posterPath: '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', backdropPath: '/xg27NrXi7VXCGUr7MN75UqLl6Vg.jpg', voteAverage: 7.6, releaseDate: '2024-06-11'),
    RemoteMovie(id: 945961, title: 'Alien: Romulus', overview: 'A group of young space colonists come face to face with the most terrifying life form in the universe.', posterPath: '/jB0W9tn4w07MFn7sTfqRTBLVytF.jpg', backdropPath: '/9SSEUrSqhljBMzRe4aBTh17wUjd.jpg', voteAverage: 7.2, releaseDate: '2024-08-14'),
    RemoteMovie(id: 533535, title: 'Deadpool & Wolverine', overview: 'Deadpool is offered a place in the Marvel Cinematic Universe by the TVA.', posterPath: '/53YWSo75mSaw1vd2YEeX5kwkRos.jpg', backdropPath: '/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg', voteAverage: 7.7, releaseDate: '2024-07-24'),
    RemoteMovie(id: 573435, title: 'Bad Boys: Ride or Die', overview: 'Miami detectives Mike and Marcus uncover a conspiracy involving their late captain.', posterPath: '/vnFFZ6Y1sudcrfNCioQW4e8NW5X.jpg', backdropPath: '/tncbMvfV0V07UZozXdBEfKTvCe2.jpg', voteAverage: 7.4, releaseDate: '2024-06-05'),
    RemoteMovie(id: 653346, title: 'Kingdom of the Planet of the Apes', overview: 'Generations after Caesar, a young ape embarks on a journey that will determine the future of both apes and humans.', posterPath: '/hBGnLm2A1TapONoPo7QrMpj2B6B.jpg', backdropPath: '/fqv8v6AycXKsivp1T5yKtLbGXce.jpg', voteAverage: 7.1, releaseDate: '2024-05-08'),
  ];

  static const _mockedListTags = {
    1: ['cozy', 'weekend', 'feel-good', 'family'],
    2: ['thriller', 'mind-bending', 'suspense', 'twist'],
    3: ['classic', 'feel-good', 'comfort', 'rom-com'],
    4: ['foreign', 'subtitles', 'world-cinema', 'festival'],
    5: ['auteur', 'masterpiece', 'cinema-history'],
    6: ['underrated', '2024', 'hidden-gem'],
    7: ['sci-fi', 'space', 'dystopia', 'future'],
    8: ['romance', 'date-night', 'comedy'],
    9: ['rewatch', 'comfort', 'nostalgia', 'all-time'],
    10: ['awards', 'oscar', 'best-picture', 'performance'],
  };

  static const _mockedFavoriteMovies = [
    RemoteMovie(id: 157336, title: 'Interstellar', overview: 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.', posterPath: '/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg', backdropPath: '/xJHokMbljXjADYdit5fK1B4Q2Nk.jpg', voteAverage: 8.7, releaseDate: '2014-11-05'),
    RemoteMovie(id: 238, title: 'The Godfather', overview: 'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family.', posterPath: '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', backdropPath: '/tmU7GeKVybMWFButWEGl2M4GeiP.jpg', voteAverage: 8.7, releaseDate: '1972-03-14'),
    RemoteMovie(id: 496243, title: 'Parasite', overview: 'All unemployed, Ki-taek\'s family takes peculiar interest in the wealthy and glamorous Parks.', posterPath: '/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', backdropPath: '/TU9aKQfPr1eiNkTOKHMm4azMkpO.jpg', voteAverage: 8.5, releaseDate: '2019-05-30'),
    RemoteMovie(id: 129, title: 'Spirited Away', overview: 'A young girl wanders into a world ruled by gods, witches, and spirits.', posterPath: '/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg', backdropPath: '/Ab8mkHmkYADjU7wQiOkia9BzGvS.jpg', voteAverage: 8.5, releaseDate: '2001-07-20'),
    RemoteMovie(id: 155, title: 'The Dark Knight', overview: 'Batman raises the stakes in his war on crime in Gotham City.', posterPath: '/qJ2tW6WMUDux911BTUOlhi7GCPY.jpg', backdropPath: '/nMKdUUepR0i5zn0y1T4CsSB5ber.jpg', voteAverage: 8.5, releaseDate: '2008-07-16'),
    RemoteMovie(id: 278, title: 'The Shawshank Redemption', overview: 'Framed in the 1940s for the double murder of his wife and her lover, Andy Dufresne begins a new life at the Shawshank prison.', posterPath: '/9cjIGRQL98cG3INaDB8Myjhqzjy.jpg', backdropPath: '/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg', voteAverage: 8.7, releaseDate: '1994-09-23'),
    RemoteMovie(id: 680, title: 'Pulp Fiction', overview: 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.', posterPath: '/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg', backdropPath: '/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg', voteAverage: 8.5, releaseDate: '1994-09-10'),
    RemoteMovie(id: 550, title: 'Fight Club', overview: 'A ticking-Loss bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.', posterPath: '/pB8BM7pdSp6B6Ih7QI4S2t0GvHd.jpg', backdropPath: '/hZkgoQYus5dXo3H8T7Uef6DNknx.jpg', voteAverage: 8.4, releaseDate: '1999-10-15'),
    RemoteMovie(id: 13, title: 'Forrest Gump', overview: 'A man with a low IQ has accomplished great things in his life and been present during significant historic events.', posterPath: '/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg', backdropPath: '/7c9UVPPiTPltouxRVY6N9uugaVA.jpg', voteAverage: 8.5, releaseDate: '1994-06-23'),
    RemoteMovie(id: 120, title: 'The Lord of the Rings: The Fellowship of the Ring', overview: 'Young hobbit Frodo Baggins must destroy a powerful ring to stop the Dark Lord Sauron.', posterPath: '/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg', backdropPath: '/pIUvQ9Ed35wlWhY2oU6OmwEgzx8.jpg', voteAverage: 8.4, releaseDate: '2001-12-18'),
    RemoteMovie(id: 424, title: 'Schindler\'s List', overview: 'The true story of how businessman Oskar Schindler saved over a thousand Jewish lives during the Holocaust.', posterPath: '/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg', backdropPath: '/loRmRzQXZC0TGAzVeMpC6FjE8MR.jpg', voteAverage: 8.6, releaseDate: '1993-11-30'),
    RemoteMovie(id: 694, title: 'The Shining', overview: 'Jack Torrance accepts a caretaker job at the Overlook Hotel, where he and his family become isolated.', posterPath: '/nRj5511mZdTl4saWEPoj9QroTIu.jpg', backdropPath: '/mmd1HnuvAzFc4iuVJcnBrhDNEKr.jpg', voteAverage: 8.2, releaseDate: '1980-05-23'),
  ];

  static const _mockedWatchList = [
    RemoteMovie(id: 426063, title: 'Nosferatu', overview: 'A gothic tale of obsession between a haunted young woman and the terrifying vampire infatuated with her.', posterPath: '/5qGIxdEO841C0tdY0Fy4gkjqAbf.jpg', backdropPath: '/vZm6aSCP4UgFfJ5bEplajuMjBOb.jpg', voteAverage: 7.6, releaseDate: '2024-12-25'),
    RemoteMovie(id: 933260, title: 'The Substance', overview: 'A fading celebrity decides to use a black market drug, a cell-replicating substance that temporarily creates a younger, better version of herself.', posterPath: '/lqoMzCcZYEFK729d6qzt349fB4o.jpg', backdropPath: '/t98L9uphqBSNn2Mkvdm3xSFCQyi.jpg', voteAverage: 7.3, releaseDate: '2024-09-07'),
    RemoteMovie(id: 1084199, title: 'A Real Pain', overview: 'Mismatched cousins reunite for a tour through Poland to honor their beloved grandmother.', posterPath: '/gBKzgQJbMEBMfcU9X5OBYIfXN4p.jpg', backdropPath: '/kHuvRFWsigNOsJQ5U0EhgWRHPaF.jpg', voteAverage: 7.0, releaseDate: '2024-11-01'),
    RemoteMovie(id: 1064028, title: 'Emilia Pérez', overview: 'A lawyer working for a large firm is recruited by the leader of a criminal organization.', posterPath: '/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', backdropPath: '/4cp40IyTpFfsT2IKpl0YlWhY2oU.jpg', voteAverage: 7.5, releaseDate: '2024-08-21'),
    RemoteMovie(id: 974453, title: 'Nickel Boys', overview: 'Based on the Pulitzer Prize-winning novel, two boys forge an unlikely bond at a brutal reform school.', posterPath: '/oJzayQz8jPycZuAvBIFdlPJRmce.jpg', backdropPath: '/pRhlaYLHHaso7V9fHhRN1qy6y40.jpg', voteAverage: 7.1, releaseDate: '2024-10-25'),
    RemoteMovie(id: 823464, title: 'Godzilla x Kong: The New Empire', overview: 'Two ancient titans, Godzilla and Kong, clash in an epic battle as humans unravel their origins.', posterPath: '/fWSGD2yrzz6hscocnMD8AEXIThk.jpg', backdropPath: '/xRd1eJIDe7JHO5u4gtEYwGn5wtf.jpg', voteAverage: 7.2, releaseDate: '2024-03-27'),
    RemoteMovie(id: 786892, title: 'Furiosa: A Mad Max Saga', overview: 'The origin story of the mighty warrior Furiosa before she joined forces with Mad Max.', posterPath: '/7qOSKoOAPgemYhBwbJgBWcCxPWZ.jpg', backdropPath: '/shrwC6U8Bkst9V9IKPmGMof8aS5.jpg', voteAverage: 7.6, releaseDate: '2024-05-22'),
    RemoteMovie(id: 1022789, title: 'Inside Out 2', overview: 'A new set of emotions join Riley\'s mind as she enters her teenage years.', posterPath: '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', backdropPath: '/xg27NrXi7VXCGUr7MN75UqLl6Vg.jpg', voteAverage: 7.6, releaseDate: '2024-06-11'),
    RemoteMovie(id: 945961, title: 'Alien: Romulus', overview: 'A group of young space colonists come face to face with the most terrifying life form in the universe.', posterPath: '/jB0W9tn4w07MFn7sTfqRTBLVytF.jpg', backdropPath: '/9SSEUrSqhljBMzRe4aBTh17wUjd.jpg', voteAverage: 7.2, releaseDate: '2024-08-14'),
    RemoteMovie(id: 533535, title: 'Deadpool & Wolverine', overview: 'Deadpool is offered a place in the Marvel Cinematic Universe by the TVA.', posterPath: '/53YWSo75mSaw1vd2YEeX5kwkRos.jpg', backdropPath: '/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg', voteAverage: 7.7, releaseDate: '2024-07-24'),
    RemoteMovie(id: 653346, title: 'Kingdom of the Planet of the Apes', overview: 'Generations after Caesar, a young ape embarks on a journey that will determine the future of both apes and humans.', posterPath: '/hBGnLm2A1TapONoPo7QrMpj2B6B.jpg', backdropPath: '/fqv8v6AycXKsivp1T5yKtLbGXce.jpg', voteAverage: 7.1, releaseDate: '2024-05-08'),
    RemoteMovie(id: 573435, title: 'Bad Boys: Ride or Die', overview: 'Miami detectives Mike and Marcus uncover a conspiracy involving their late captain.', posterPath: '/vnFFZ6Y1sudcrfNCioQW4e8NW5X.jpg', backdropPath: '/tncbMvfV0V07UZozXdBEfKTvCe2.jpg', voteAverage: 7.4, releaseDate: '2024-06-05'),
  ];

  static const int _pageSize = 4;
  static const int _favoriteMoviesPageSize = 6;
  static const int _watchListPageSize = 6;
  static const int _listDetailPageSize = 6;

  @override
  Future<Result<RemoteMovieListing>> getTrendingMovieList({
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'trending/movie/week',
      queryParams: {'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  static const _mockedWatchProviders = [
    RemoteWatchProvider(name: 'Netflix', logoPath: '/pbpMk2JmcoNnQwx5JGpXngfoWtp.jpg'),
    RemoteWatchProvider(name: 'Amazon Prime Video', logoPath: '/emthp39XA2YScoYL1p0sdbAH2WA.jpg'),
    RemoteWatchProvider(name: 'Disney+', logoPath: '/7rwgEs15tFwyR9NPQ5vpzxTj19Q.jpg'),
    RemoteWatchProvider(name: 'Apple TV+', logoPath: '/6uhKBfmtzFqOcLousHwZuzcrScK.jpg'),
    RemoteWatchProvider(name: 'Max', logoPath: '/aS2zvJUn9gFOjVEgogbAPHAOPKx.jpg'),
  ];

  static const _mockedPopularReviews = [
    RemoteMovieReview(
      id: 0,
      title: '',
      date: 'Mar 12, 2024',
      rating: 4.5,
      author: 'CinephileAna',
      content: 'A visually stunning masterpiece that stays with you long after the credits roll. The performances are extraordinary and the direction is impeccable.',
    ),
    RemoteMovieReview(
      id: 0,
      title: '',
      date: 'Mar 8, 2024',
      rating: 4.0,
      author: 'MovieBuff42',
      content: 'Impressive storytelling with a few pacing issues in the second act, but the finale more than makes up for it. One of the best of the year.',
    ),
    RemoteMovieReview(
      id: 0,
      title: '',
      date: 'Feb 28, 2024',
      rating: 3.5,
      author: 'FilmCriticLeo',
      content: 'Well-crafted but doesn\'t quite reach the heights of its predecessor. Still, the cinematography alone makes it worth watching on the big screen.',
    ),
  ];

  @override
  Future<Result<RemoteMovieDetail>> getMovieDetail({
    required int movieId,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'movie/$movieId',
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) => () {
          final detail = RemoteMovieDetail.fromJson(data);
          final similarCount = _mockedListMovies.length.clamp(0, 6);
          return Success(RemoteMovieDetail(
            id: detail.id,
            title: detail.title,
            overview: detail.overview,
            posterPath: detail.posterPath,
            backdropPath: detail.backdropPath,
            voteAverage: detail.voteAverage,
            releaseDate: detail.releaseDate,
            tagline: detail.tagline,
            runtime: detail.runtime,
            genres: detail.genres,
            director: 'Denis Villeneuve',
            cast: const ['Timothée Chalamet', 'Zendaya', 'Rebecca Ferguson', 'Josh Brolin', 'Austin Butler'],
            watchProviders: _mockedWatchProviders.take(3).toList(),
            similarMovies: _mockedListMovies.take(similarCount).toList(),
            popularReviews: _mockedPopularReviews,
            reviewCount: (movieId % 50) + 12,
            listCount: (movieId % 30) + 5,
            likeCount: (movieId % 500) + 80,
          ));
        }(),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteMovieReviewListing>> getMovieReviews({
    required int page,
    String? userId,
    int? movieId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedReviews.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageReviews = _mockedReviews.sublist(
      startIndex.clamp(0, _mockedReviews.length),
      endIndex.clamp(0, _mockedReviews.length),
    );

    return Success(RemoteMovieReviewListing(
      totalPages: totalPages,
      totalResults: _mockedReviews.length,
      reviews: pageReviews,
    ));
  }


  @override
  Future<Result<RemoteMovieListListing>> getMovieLists({
    required int page,
    String? userId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedLists.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageLists = _mockedLists.sublist(
      startIndex.clamp(0, _mockedLists.length),
      endIndex.clamp(0, _mockedLists.length),
    );

    return Success(RemoteMovieListListing(
      totalPages: totalPages,
      totalResults: _mockedLists.length,
      lists: pageLists,
    ));
  }

  @override
  Future<Result<RemoteMovieListListing>> getUserMovieLists({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedLists.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageLists = _mockedLists.sublist(
      startIndex.clamp(0, _mockedLists.length),
      endIndex.clamp(0, _mockedLists.length),
    );

    return Success(RemoteMovieListListing(
      totalPages: totalPages,
      totalResults: _mockedLists.length,
      lists: pageLists,
    ));
  }

  @override
  Future<Result<RemoteMovieListDetail>> getMovieListDetail({
    required int listId,
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final list = _mockedLists.firstWhere(
      (list) => list.id == listId,
      orElse: () => _mockedLists.first,
    );

    final totalPages = (_mockedListMovies.length / _listDetailPageSize).ceil();
    final startIndex = (page - 1) * _listDetailPageSize;
    final endIndex = startIndex + _listDetailPageSize;
    final pageMovies = _mockedListMovies.sublist(
      startIndex.clamp(0, _mockedListMovies.length),
      endIndex.clamp(0, _mockedListMovies.length),
    );

    return Success(RemoteMovieListDetail(
      id: list.id,
      name: list.name,
      creator: list.creator,
      description: list.description,
      movies: pageMovies,
      totalMovies: _mockedListMovies.length,
      totalPages: totalPages,
      commentsCount: (listId * 7 + 3) % 50,
      likesCount: (listId * 13 + 11) % 200,
      isLiked: listId % 3 == 0,
      tags: _mockedListTags[listId] ?? ['movies'],
    ));
  }

  @override
  Future<Result<RemoteMovieListing>> searchMovies({
    required String query,
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'search/movie',
      queryParams: {'query': query, 'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteMovieListing>> discoverMovies({
    required int page,
    int? primaryReleaseYear,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
    String? withGenres,
    String? withOriginalLanguage,
    String? withOriginCountry,
    int? minimumVoteCount,
  }) async {
    final queryParams = <String, dynamic>{'page': page};
    if (primaryReleaseYear != null) {
      queryParams['primary_release_year'] = primaryReleaseYear;
    }
    if (releaseDateGte != null) {
      queryParams['primary_release_date.gte'] = releaseDateGte;
    }
    if (releaseDateLte != null) {
      queryParams['primary_release_date.lte'] = releaseDateLte;
    }
    if (sortBy != null) {
      queryParams['sort_by'] = sortBy;
    }
    if (withGenres != null) {
      queryParams['with_genres'] = withGenres;
    }
    if (withOriginalLanguage != null) {
      queryParams['with_original_language'] = withOriginalLanguage;
    }
    if (withOriginCountry != null) {
      queryParams['with_origin_country'] = withOriginCountry;
    }
    if (minimumVoteCount != null) {
      queryParams['vote_count.gte'] = minimumVoteCount;
    }

    final result = await _httpClient.get<Map<String, dynamic>>(
      'discover/movie',
      queryParams: queryParams,
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<List<RemoteGenre>>> getGenres() async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'genre/movie/list',
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) => Success(
          (data['genres'] as List)
              .map((genre) => RemoteGenre.fromJson(genre as Map<String, dynamic>))
              .toList(),
        ),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<List<RemoteCountry>>> getCountries() async {
    final result = await _httpClient.get<List<dynamic>>(
      'configuration/countries',
    );

    return switch (result) {
      Success<List<dynamic>>(:final data) => Success(
          data
              .map((country) => RemoteCountry.fromJson(country as Map<String, dynamic>))
              .toList()
            ..sort((first, second) => first.englishName.compareTo(second.englishName)),
        ),
      Failure<List<dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<List<RemoteLanguage>>> getLanguages() async {
    final result = await _httpClient.get<List<dynamic>>(
      'configuration/languages',
    );

    return switch (result) {
      Success<List<dynamic>>(:final data) => Success(
          data
              .map((language) => RemoteLanguage.fromJson(language as Map<String, dynamic>))
              .toList(),
        ),
      Failure<List<dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteMovieListing>> getUserFavoriteMovies({
    required String userId,
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages =
        (_mockedFavoriteMovies.length / _favoriteMoviesPageSize).ceil();
    final startIndex = (page - 1) * _favoriteMoviesPageSize;
    final endIndex = startIndex + _favoriteMoviesPageSize;
    final pageMovies = _mockedFavoriteMovies.sublist(
      startIndex.clamp(0, _mockedFavoriteMovies.length),
      endIndex.clamp(0, _mockedFavoriteMovies.length),
    );

    return Success(RemoteMovieListing(
      totalPages: totalPages,
      totalResults: _mockedFavoriteMovies.length,
      movies: pageMovies,
    ));
  }

  static const _mockedFeaturedLists = [
    RemoteMovieList(
      id: 101,
      name: 'Staff Picks: Spring 2024',
      creator: 'Moovie Editors',
      description: 'Our editors\' hand-picked selection of the most exciting films this spring. From bold indie debuts to highly anticipated sequels, these are the movies we think deserve a spot on your watchlist right now.',
      movieCount: 15,
      posterPaths: ['/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg', '/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', '/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg'],
    ),
    RemoteMovieList(
      id: 102,
      name: 'Hidden Gems You Missed',
      creator: 'Moovie Editors',
      description: 'These under-the-radar films deserve far more attention than they got. From festival darlings that never found a wide audience to quiet dramas with powerhouse performances, this list celebrates the movies that slipped through the cracks.',
      movieCount: 20,
      posterPaths: ['/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg', '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg'],
    ),
    RemoteMovieList(
      id: 103,
      name: 'Best Directorial Debuts',
      creator: 'Moovie Editors',
      description: 'First-time directors who knocked it out of the park. These debut features showcase raw talent and bold vision that signal the arrival of exciting new voices in cinema.',
      movieCount: 12,
      posterPaths: ['/53YWSo75mSaw1vd2YEeX5kwkRos.jpg', '/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg', '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', '/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg'],
    ),
    RemoteMovieList(
      id: 104,
      name: 'Essential Documentaries',
      creator: 'Moovie Editors',
      description: 'Documentaries that will change how you see the world. These non-fiction masterpieces cover everything from environmental crises to personal triumphs, each one crafted with the storytelling power of the best fiction.',
      movieCount: 18,
      posterPaths: ['/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg', '/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg'],
    ),
    RemoteMovieList(
      id: 105,
      name: 'Soundtrack Standouts',
      creator: 'Moovie Editors',
      description: 'Films where the music is as memorable as the story. From sweeping orchestral scores to perfectly curated needle drops, these movies prove that great sound design and music can elevate cinema to an entirely different level.',
      movieCount: 16,
      posterPaths: ['/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', '/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/53YWSo75mSaw1vd2YEeX5kwkRos.jpg', '/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg'],
    ),
    RemoteMovieList(
      id: 106,
      name: 'Animation Beyond Disney',
      creator: 'Moovie Editors',
      description: 'Animated films from studios around the world that push the boundaries of the medium. From Japanese anime to European stop-motion, these films prove that animation is not just for kids.',
      movieCount: 14,
      posterPaths: ['/aNK6MA5EApIo0UJE7ZWSYcZBJKy.jpg', '/lHKNS35r4RTa9GO72vdadMLxoiV.jpg', '/8LJJjLjAzAwXS40S5mx79PJ2jSs.jpg'],
    ),
    RemoteMovieList(
      id: 107,
      name: 'Performances of the Year',
      creator: 'Moovie Editors',
      description: 'The most unforgettable acting performances from the past year. These actors disappeared into their roles and delivered work that will be remembered for decades.',
      movieCount: 10,
      posterPaths: ['/6EO0cjZt2vzAOmuDJZGED6GQmi4.jpg', '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg', '/1OsQJEoSXBjduuCvDOlRhoEUaHu.jpg', '/yRRuLt7sMBEQkHsd1S3KaaofZn7.jpg'],
    ),
    RemoteMovieList(
      id: 108,
      name: 'Modern Horror Essentials',
      creator: 'Moovie Editors',
      description: 'The best horror films of the 2020s. Elevated horror meets visceral scares in this collection of modern classics that redefine what the genre can achieve.',
      movieCount: 22,
      posterPaths: ['/xmFdNzbUiT5XmH6rbIVGYDQHGeo.jpg', '/53YWSo75mSaw1vd2YEeX5kwkRos.jpg', '/iOdcXYSVzBgmBJzNIlIMOZ6fz0F.jpg'],
    ),
  ];

  static const int _featuredListsPageSize = 4;

  @override
  Future<Result<RemoteMovieListing>> getUserWatchList({
    required String userId,
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages =
        (_mockedWatchList.length / _watchListPageSize).ceil();
    final startIndex = (page - 1) * _watchListPageSize;
    final endIndex = startIndex + _watchListPageSize;
    final pageMovies = _mockedWatchList.sublist(
      startIndex.clamp(0, _mockedWatchList.length),
      endIndex.clamp(0, _mockedWatchList.length),
    );

    return Success(RemoteMovieListing(
      totalPages: totalPages,
      totalResults: _mockedWatchList.length,
      movies: pageMovies,
    ));
  }

  @override
  Future<Result<RemoteMovieListListing>> getFeaturedLists({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages =
        (_mockedFeaturedLists.length / _featuredListsPageSize).ceil();
    final startIndex = (page - 1) * _featuredListsPageSize;
    final endIndex = startIndex + _featuredListsPageSize;
    final pageLists = _mockedFeaturedLists.sublist(
      startIndex.clamp(0, _mockedFeaturedLists.length),
      endIndex.clamp(0, _mockedFeaturedLists.length),
    );

    return Success(RemoteMovieListListing(
      totalPages: totalPages,
      totalResults: _mockedFeaturedLists.length,
      lists: pageLists,
    ));
  }
}
