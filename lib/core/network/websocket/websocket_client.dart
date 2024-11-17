import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../core/utils/constant.dart';
import 'websocket_manager.dart';

class WebSocketClient {
  static WebSocketClient? _instance;
  late final WebSocketManager _manager;

  WebSocketClient._() {
    _manager = WebSocketManager('${ApiConstants.wsBaseUrl}/ws');
  }

  static WebSocketClient get instance {
    _instance ??= WebSocketClient._();
    return _instance!;
  }

  WebSocketChannel connect() {
    return _manager.connect();
  }

  void disconnect() {
    _manager.disconnect();
  }

  bool get isConnected => _manager.isConnected;

  WebSocketChannel get channel => _manager.channel;
}