import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../core/network/websocket/websocket_client.dart';
import '../../../dto/common/response_wrapper/response_wrapper.dart';
import '../../../dto/trade/trade_dto.dart';
import 'trade_api_interface.dart';

class TradeApiClient implements TradeApiInterface {
  late final WebSocketChannel channel;

  TradeApiClient() {
    channel = WebSocketClient.instance.connect();
  }

  @override
  Future<ResponseWrapper<Map<String, dynamic>>> startTrade(TradeDto tradeDto) async {
    try {
      channel.sink.add(jsonEncode(tradeDto.toJson()));

      final response = await channel.stream.firstWhere(
              (message) => jsonDecode(message)['uid'] == tradeDto.uid
      );

      final decodedResponse = jsonDecode(response);
      return ResponseWrapper<Map<String, dynamic>>(
        status: decodedResponse['ok'] ?? false,
        code: 'SUCCESS',
        message: decodedResponse['message'],
        data: decodedResponse['result'],
      );
    } catch (e) {
      return ResponseWrapper(
        status: false,
        code: 'SOCKET_ERROR',
        message: e.toString(),
      );
    }
  }

  @override
  Future<ResponseWrapper<void>> stopTrade(String uid) async {
    try {
      final stopRequest = {
        'task': 'stop_trade',
        'uid': uid,
      };

      channel.sink.add(jsonEncode(stopRequest));

      final response = await channel.stream.firstWhere(
              (message) => jsonDecode(message)['uid'] == uid
      );

      final decodedResponse = jsonDecode(response);
      return ResponseWrapper<void>(
        status: decodedResponse['ok'] ?? false,
        code: 'SUCCESS',
        message: decodedResponse['message'],
      );
    } catch (e) {
      return ResponseWrapper(
        status: false,
        code: 'SOCKET_ERROR',
        message: e.toString(),
      );
    }
  }

  @override
  Stream<TradePositionDto> getPositionUpdates(String uid) {
    return channel.stream
        .where((message) {
      final decoded = jsonDecode(message);
      return decoded['uid'] == uid && decoded['position'] != null;
    })
        .map((message) => TradePositionDto.fromJson(jsonDecode(message)));
  }

  void dispose() {
    channel.sink.close();
  }
}