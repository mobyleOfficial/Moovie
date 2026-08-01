import 'dart:async';

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
    await _fetchUserProfile();

    await _webSocketClient.connect();
    _wsSubscription = _webSocketClient.messages.listen(_handleMessage);
  }

  void _handleMessage(Map<String, dynamic> message) {
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
