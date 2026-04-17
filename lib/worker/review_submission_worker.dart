import 'package:movies/movies.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

const submitReviewTaskName = 'submitReview';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName != submitReviewTaskName || inputData == null) return false;

    final movieId = inputData['movieId'] as int?;
    if (movieId == null) return false;

    final appDir = await getApplicationDocumentsDirectory();
    final store = openStore(directory: '${appDir.path}/objectbox');

    try {
      final box = store.box<LocalMovieReviewDraft>();
      final draft = box
          .query(LocalMovieReviewDraft_.movieId.equals(movieId))
          .build()
          .findFirst();

      if (draft == null) return true;

      await Future<void>.delayed(const Duration(seconds: 3));

      box.remove(draft.id);
      return true;
    } catch (_) {
      final box = store.box<LocalMovieReviewDraft>();
      final draft = box
          .query(LocalMovieReviewDraft_.movieId.equals(movieId))
          .build()
          .findFirst();

      if (draft != null) {
        draft.statusIndex = MovieReviewStatus.error.index;
        box.put(draft);
      }
      return false;
    } finally {
      store.close();
    }
  });
}

Future<void> scheduleReviewSubmission({required int movieId}) =>
    Workmanager().registerOneOffTask(
      'submitReview_$movieId',
      submitReviewTaskName,
      inputData: {'movieId': movieId},
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
