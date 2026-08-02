import 'dart:async';
import 'dart:developer' as dev;

import 'package:core/core.dart';
import 'package:profile/profile.dart';

class AppInitializer {
  final WebSocketClient _webSocketClient;
  final ProfileRepository _profileRepository;
  final FetchUserProfile _fetchUserProfile;

  StreamSubscription<Map<String, dynamic>>? _wsSubscription;

  AppInitializer({
    required WebSocketClient webSocketClient,
    required ProfileRepository profileRepository,
    required FetchUserProfile fetchUserProfile,
  })  : _webSocketClient = webSocketClient,
        _profileRepository = profileRepository,
        _fetchUserProfile = fetchUserProfile;

  Future<void> initialize() async {
    _wsSubscription = _webSocketClient.messages.listen(_handleMessage);

    unawaited(_fetchUserProfile().catchError(
      (Object e) => dev.log('[AppInit] fetchProfile failed: $e'),
    ));

    unawaited(_webSocketClient.connect().catchError(
      (Object e) => dev.log('[AppInit] WebSocket connect failed: $e'),
    ));
  }

  void _handleMessage(Map<String, dynamic> message) {
    dev.log('[AppInit] WS message: $message');
    final type = message['type'] as String?;
    if (type == 'scrape_finished' || type == 'scrape_failed') {
      _profileRepository.onScrapeComplete();
    }
  }

  Future<void> dispose() async {
    await _wsSubscription?.cancel();
    await _webSocketClient.dispose();
  }
}
