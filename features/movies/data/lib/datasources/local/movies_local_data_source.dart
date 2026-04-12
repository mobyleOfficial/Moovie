import 'package:core/core.dart';
import 'package:movies_data/models/local/local_recent_search.dart';

abstract interface class MoviesLocalDataSource {
  Result<void> addRecentSearch(String query);
  Stream<List<LocalRecentSearch>> watchRecentSearches();
}
