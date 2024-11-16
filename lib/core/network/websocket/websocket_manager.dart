import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketManager {
  WebSocketChannel? _channel;
  final String url;

  WebSocketManager(this.url);

  WebSocketChannel connect() {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    return _channel!;
  }

  void disconnect() {
    _channel?.sink.close(status.goingAway);
  }

  bool get isConnected => _channel != null;

  WebSocketChannel get channel {
    if (_channel == null) {
      throw Exception('WebSocket not connected');
    }
    return _channel!;
  }
}