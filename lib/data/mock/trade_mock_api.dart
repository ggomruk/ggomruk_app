import 'dart:async';
import 'dart:convert';

import '../../core/utils/logger.dart';
import '../data_source/remote/trade/trade_api_interface.dart';
import '../dto/trade/trade_dto.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import 'trade_mock_data.dart';

class TradeMockApiClient implements TradeApiInterface {
  final _positionController = StreamController<TradePositionDto>.broadcast();
  Timer? _mockUpdateTimer;
  final Map<String, Timer> _activeStreams = {};

  @override
  Future<ResponseWrapper<Map<String, dynamic>>> startTrade(TradeDto tradeDto) async {
    try {
      CustomLogger.logger.i('📤 WebSocket Request (START_TRADE):');
      CustomLogger.logger.i(jsonEncode({
        "task": tradeDto.task,
        "uid": tradeDto.uid,
        "params": tradeDto.params.toJson(),
      }));
      _cleanupStream(tradeDto.uid);
      _startMockUpdates(tradeDto.uid, tradeDto.params.interval);

      final mockResponse = TradeMockData.mockResponses["start"]!;
      final response = ResponseWrapper<Map<String, dynamic>>(
        status: mockResponse["ok"] as bool,      // mockResponses의 ok 값 사용
        code: 'SUCCESS',
        message: mockResponse["message"] as String,
        data: mockResponse["result"] as Map<String, dynamic>,  // mockResponses의 result 값 사용
      );

      CustomLogger.logger.i('📥 WebSocket Response (START_TRADE):');
      CustomLogger.logger.i(jsonEncode({
        "status": response.status,
        "code": response.code,
        "message": response.message,
        "data": response.data,
      }));

      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseWrapper<void>> stopTrade(String uid) async {
    try {
      CustomLogger.logger.i('📤 WebSocket Request (STOP_TRADE):');
      CustomLogger.logger.i(jsonEncode({
        "task": "stop_trade",
        "uid": uid,
      }));

      _cleanupStream(uid);

      final response = ResponseWrapper<void>(
        status: true,
        code: 'SUCCESS',
        message: TradeMockData.mockResponses["stop"]!["message"] as String,
      );

      CustomLogger.logger.i('📥 WebSocket Response (STOP_TRADE):');
      CustomLogger.logger.i(jsonEncode({
        "status": response.status,
        "code": response.code,
        "message": response.message,
      }));

      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Stream<TradePositionDto> getPositionUpdates(String uid) {
    return _positionController.stream.where((update) => update.uid == uid);
  }

  void _startMockUpdates(String uid, String interval) {
    CustomLogger.logger.i('🔄 Starting position updates:');
    CustomLogger.logger.i('UID: $uid, Interval: $interval');

    final duration = _parseInterval(interval);

    _activeStreams[uid] = Timer.periodic(duration, (timer) {
      if (!_positionController.isClosed) {
        final update = TradeMockData.generatePositionUpdate(uid);
        _positionController.add(update);

        CustomLogger.logger.i('📥 Position Update:');
        CustomLogger.logger.i(jsonEncode({
          "uid": update.uid,
          "position": update.position,
          "timestamp": update.timestamp.toIso8601String(),
        }));
      } else {
        timer.cancel();
      }
    });
  }

  Duration _parseInterval(String interval) {
    // 테스트를 위해 실제 간격의 1/60로 설정
    final value = int.parse(interval.substring(0, interval.length - 1));
    final unit = interval.substring(interval.length - 1);

    switch (unit) {
      case 'm':
        return Duration(seconds: value); // minutes -> seconds
      case 'h':
        return Duration(minutes: value); // hours -> minutes
      default:
        return const Duration(seconds: 1); // 기본값
    }
  }

  void _cleanupStream(String uid) {
    _activeStreams[uid]?.cancel();
    _activeStreams.remove(uid);
  }

  ResponseWrapper<T> _handleError<T>(dynamic error) {
    CustomLogger.logger.e('❌ Error in WebSocket:');
    CustomLogger.logger.e(error.toString());

    if (error is FormatException) {
      return ResponseWrapper(
        status: false,
        code: 'FORMAT_ERROR',
        message: 'Invalid response format',
      );
    }
    return ResponseWrapper(
      status: false,
      code: 'UNEXPECTED_ERROR',
      message: error.toString(),
    );
  }


  void dispose() {
    CustomLogger.logger.i('🔚 Disposing WebSocket connections');
    for (var timer in _activeStreams.values) {
      timer.cancel();
    }
    _activeStreams.clear();
    _positionController.close();
  }
}