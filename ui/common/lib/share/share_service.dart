import 'package:movies_domain/domain.dart';
import 'package:share_plus/share_plus.dart';

/// Abstract contract for sharing a [MovieReview] to external apps via the OS
/// share sheet. Implemented by [SharePlusShareService] in production. Pure-Dart
/// contract so widget tests can stub it without platform-channel mocks.
abstract interface class ShareService {
  Future<void> shareReview(MovieReview review);
}

/// `share_plus`-backed implementation. Builds the share payload defined in the
/// Review Details spec:
/// `<movieTitle> — <rating>/5 — review by <author> on Muuvie\n\n<deeplinkUrl>`.
class SharePlusShareService implements ShareService {
  const SharePlusShareService();

  static const String _deeplinkPrefix = 'https://muuvie.app/reviews/';

  @override
  Future<void> shareReview(MovieReview review) async {
    final author = review.author ?? 'Anonymous';
    final ratingLabel =
        review.rating % 1 == 0 ? review.rating.toInt().toString() : review.rating.toString();
    final deeplink = '$_deeplinkPrefix${review.id}';
    final payload =
        '${review.title} — $ratingLabel/5 — review by $author on Muuvie\n\n$deeplink';
    await SharePlus.instance.share(ShareParams(text: payload));
  }
}
