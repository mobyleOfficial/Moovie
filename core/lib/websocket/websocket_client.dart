import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:web_socket_channel/io.dart';
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

      final httpUri = Uri.parse(_baseUrl);
      final wsScheme = httpUri.scheme == 'https' ? 'wss' : 'ws';
      final wsUri = Uri(
        scheme: wsScheme,
        host: httpUri.host,
        port: httpUri.port,
        path: '/ws',
      );

      dev.log('[WS] Connecting to $wsUri');

      _channel = IOWebSocketChannel.connect(
        wsUri,
        headers: {'Authorization': nonce},
      );
      await _channel!.ready;

      dev.log('[WS] Connected');

      _channel!.stream.listen(
        (data) {
          if (_disposed) return;
          dev.log('[WS] Raw message received: $data');
          try {
            final json = jsonDecode(data as String) as Map<String, dynamic>;
            dev.log('[WS] Parsed message: type=${json['type']}, data=$json');
            _controller.add(json);
          } catch (e) {
            dev.log('[WS] Failed to parse message: $e');
          }
        },
        onDone: () {
          dev.log('[WS] Connection closed (onDone)');
          _scheduleReconnect();
        },
        onError: (e) {
          dev.log('[WS] Stream error: $e');
          _scheduleReconnect();
        },
      );
    } catch (e) {
      dev.log('[WS] Connection failed: $e');
      _scheduleReconnect();
    }
  }

  Future<String?> _exchangeTokenForNonce() async {
    try {
      final response = await _dio.post<Map<String, dynamic>>('/ws/token');
      return response.data?['token'] as String?;
    } catch (e) {
      dev.log('[WS] Token exchange failed: $e');
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
