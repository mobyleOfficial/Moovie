import 'package:movies_domain/models/recent_search.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class ObserveRecentSearches {
  final MoviesRepository _moviesRepository;

  ObserveRecentSearches(this._moviesRepository);

  Stream<List<RecentSearch>> call() =>
      _moviesRepository.observeRecentSearches();
}
