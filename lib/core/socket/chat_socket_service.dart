import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../constants/constants/constants.dart';
import '../../constants/env/env_constants.dart';
import '../service/env_service.dart';
import '../storage/local/app_settings_prefs.dart';

/// Manages the Socket.IO connection for the chat feature.
///
/// Events:
///   emit  → join_conversation, send_message
///   listen → message_received
class ChatSocketService {
  final AppSettingsPrefs _appSettingsPrefs;

  IO.Socket? _socket;

  /// Stream that broadcasts every incoming message payload.
  final _messageController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get onMessageReceived =>
      _messageController.stream;

  /// Stream that broadcasts user online/offline status changes.
  final _userStatusController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get onUserStatusChanged =>
      _userStatusController.stream;

  /// Whether the socket is currently connected.
  bool get isConnected => _socket?.connected ?? false;

  ChatSocketService(this._appSettingsPrefs);

  // ─────────────────────────────────────────────────────
  // Connection lifecycle
  // ─────────────────────────────────────────────────────

  String? _connectedToken;

  /// Opens the socket connection to the /chat namespace.
  /// Always reconnects when the auth token changes (new login).
  void connect() {
    final token = _appSettingsPrefs.getToken();
    if (token.isEmpty) {
      disconnect();
      return;
    }

    if (_socket != null &&
        _socket!.connected &&
        _connectedToken == token) {
      return;
    }

    // Drop any previous connection (wrong user / stale token).
    if (_socket != null) {
      _socket!.dispose();
      _socket = null;
    }

    final baseUrl = EnvService.getString(key: EnvConstants.socketUrl);
    _connectedToken = token;

    _socket = IO.io(
      '$baseUrl/chat',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          // Nest chat gateway prefers handshake.auth.token; headers often drop on WS.
          .setAuth({'token': token})
          .setQuery({'token': token})
          .setExtraHeaders({
            Constants.authorization: '${Constants.bearer} $token',
          })
          .build(),
    );

    _socket!.onConnect((_) {
      if (kDebugMode) debugPrint('[ChatSocket] Connected');
    });

    _socket!.onDisconnect((_) {
      if (kDebugMode) debugPrint('[ChatSocket] Disconnected');
    });

    _socket!.onConnectError((err) {
      if (kDebugMode) debugPrint('[ChatSocket] Connection error: $err');
    });

    _socket!.onError((err) {
      if (kDebugMode) debugPrint('[ChatSocket] Error: $err');
    });

    // Listen for incoming messages
    _socket!.on('message_received', (data) {
      if (data is Map<String, dynamic>) {
        _messageController.add(data);
      } else if (data is Map) {
        _messageController.add(Map<String, dynamic>.from(data));
      }
    });

    // Listen for user online/offline status
    _socket!.on('user_status', (data) {
      if (data is Map<String, dynamic>) {
        _userStatusController.add(data);
      } else if (data is Map) {
        _userStatusController.add(Map<String, dynamic>.from(data));
      }
    });

    _socket!.connect();
  }

  /// Disconnects the socket gracefully.
  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _connectedToken = null;
  }

  // ─────────────────────────────────────────────────────
  // Emit events
  // ─────────────────────────────────────────────────────

  /// Joins a conversation room so the server routes messages here.
  void joinConversation(String conversationId) {
    _socket?.emit('join_conversation', {
      'conversationId': conversationId,
    });
  }

  /// Sends a text message through the socket.
  void sendMessage({
    required String conversationId,
    required String content,
  }) {
    _socket?.emit('send_message', {
      'conversationId': conversationId,
      'content': content,
    });
  }

  /// Asks the server for the online status of the other user in a conversation.
  void checkUserStatus(String conversationId) {
    _socket?.emit('check_user_status', {
      'conversationId': conversationId,
    });
  }

  /// Releases resources. Call when the service is no longer needed.
  void dispose() {
    disconnect();
    _messageController.close();
    _userStatusController.close();
  }
}
