import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'movies_data_source.dart';

@injectable
class MoviesDataSourceImpl implements MoviesDataSource {
  final HttpClient _httpClient;

  MoviesDataSourceImpl(this._httpClient);
}