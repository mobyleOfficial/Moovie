import 'package:core/core.dart';

import 'package:movies_domain/repositories/movies_repository.dart';

class DeleteDraft extends UseCase<int, Result<void>> {
  final MoviesRepository _moviesRepository;

  DeleteDraft(this._moviesRepository);

  @override
  Future<Result<void>> call([int? params]) async =>
      _moviesRepository.deleteDraft(movieId: params ?? 0);
}
