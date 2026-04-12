import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class ObserveMovieReviewDraftsList {
  final UserActivitiesRepository _userActivitiesRepository;

  ObserveMovieReviewDraftsList(this._userActivitiesRepository);

  Stream<List<MovieReviewDraft>> call() =>
      _userActivitiesRepository.observeMovieReviewDraftsList();
}
