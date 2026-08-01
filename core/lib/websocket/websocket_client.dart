import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient {
  final String _baseUrl;
  final Dio _dio;

  WebSocketChannel? _channel;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Timer? _reconnectTimer;
  bool _disposed = false;

  Stream<Map<String, dynamic>> get messages => _controller.stream;

  WebSocketClient({
    required String baseUrl,
    required Dio dio,
  })  : _baseUrl = baseUrl,
        _dio = dio;

  Future<void> connect() async {
    if (_disposed) return;

    try {
      final nonce = await _exchangeTokenForNonce();
      if (nonce == null) {
        _scheduleReconnect();
        return;
      }

      final wsUrl = _baseUrl
          .replaceFirst('https://', 'wss://')
          .replaceFirst('http://', 'ws://');

      _channel = WebSocketChannel.connect(
        Uri.parse('$wsUrl/ws?token=$nonce'),
      );

      _channel!.stream.listen(
        (data) {
          if (_disposed) return;
          try {
            final json = jsonDecode(data as String) as Map<String, dynamic>;
            _controller.add(json);
          } catch (_) {}
        },
        onDone: () => _scheduleReconnect(),
        onError: (_) => _scheduleReconnect(),
      );
    } catch (_) {
      _scheduleReconnect();
    }
  }

  Future<String?> _exchangeTokenForNonce() async {
    try {
      final response = await _dio.post<Map<String, dynamic>>('/ws/token');
      return response.data?['token'] as String?;
    } catch (_) {
      return null;
    }
  }

  void _scheduleReconnect() {
    if (_disposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), connect);
  }

  Future<void> dispose() async {
    _disposed = true;
    _reconnectTimer?.cancel();
    await _channel?.sink.close();
    await _controller.close();
  }
}
