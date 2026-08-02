import 'dart:async';
import 'dart:developer' as dev;

import 'package:core/core.dart';
import 'package:profile/profile.dart';

class AppInitializer {
  final WebSocketClient _webSocketClient;
  final FetchUserProfile _fetchUserProfile;

  StreamSubscription<WsMessage>? _wsSubscription;

  AppInitializer({
    required WebSocketClient webSocketClient,
    required FetchUserProfile fetchUserProfile,
  })  : _webSocketClient = webSocketClient,
        _fetchUserProfile = fetchUserProfile;

  Future<void> initialize() async {
    unawaited(_fetchUserProfile().catchError(
      (Object e) => dev.log('[AppInit] fetchProfile failed: $e'),
    ));

    unawaited(_webSocketClient.connect().catchError(
      (Object e) => dev.log('[AppInit] WebSocket connect failed: $e'),
    ));
  }

  Future<void> dispose() async {
    await _wsSubscription?.cancel();
    await _webSocketClient.dispose();
  }
}
