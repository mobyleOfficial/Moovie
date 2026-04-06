import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class ObserveMovieReviewDraftsList {
  final MoviesRepository _moviesRepository;

  ObserveMovieReviewDraftsList(this._moviesRepository);

  Stream<List<MovieReviewDraft>> call() =>
      _moviesRepository.observeMovieReviewDraftsList();
}
