import 'package:movies/movies.dart';

sealed class MainState {
  const MainState();
}

class MainLoading extends MainState {
  const MainLoading();
}

class MainSuccess extends MainState {
  final List<MovieReviewDraft> submittingDrafts;

  const MainSuccess({this.submittingDrafts = const []});

  bool get hasSubmissions => submittingDrafts.isNotEmpty;

  bool get hasError =>
      submittingDrafts.any((draft) => draft.status == MovieReviewStatus.error);

  MovieReviewDraft? get firstSubmitting => submittingDrafts
      .where((draft) => draft.status == MovieReviewStatus.submitting)
      .firstOrNull;

  MovieReviewDraft? get firstError => submittingDrafts
      .where((draft) => draft.status == MovieReviewStatus.error)
      .firstOrNull;
}
