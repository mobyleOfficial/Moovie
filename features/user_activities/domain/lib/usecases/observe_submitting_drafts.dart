import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class ObserveSubmittingDrafts {
  final UserActivitiesRepository _repository;

  ObserveSubmittingDrafts(this._repository);

  Stream<List<MovieReviewDraft>> call() =>
      _repository.observeSubmittingDrafts();
}
