import 'dart:math';
import '../dto/trade/trade_dto.dart';

class TradeMockData {
  static final TradeDto mockRequest = TradeDto(
    uid: "trade_001",
    task: 'trade',
    params: TradeParams(
      symbol: "BTCUSDT",
      interval: "5m",
      strategies: {
        "MACD": {
          "ema_s": 12,
          "ema_l": 26,
          "signal_mw": 9
        },
        "SO": {
          "periods": 14,
          "d_mw": 3
        }
      },
    ),
  );

  static TradePositionDto generatePositionUpdate(String uid) {
    final random = Random();

    final positions = [-1.0, 0.0, 1.0];
    final position = positions[random.nextInt(positions.length)];

    return TradePositionDto(
      uid: uid,
      position: position,
      timestamp: DateTime.now(),
    );
  }

  static final Map<String, Map<String, dynamic>> mockResponses = {
    "start": {
      "ok": true,
      "message": "Trading started",
      "result": {"uid": "trade_001"}
    },
    "stop": {
      "ok": true,
      "message": "Trading stopped"
    },
    "error": {
      "ok": false,
      "error": "No active trading session found"
    }
  };
}