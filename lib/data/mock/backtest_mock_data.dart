import '../dto/backtest/backtest_dto.dart';

class BacktestMockData {
  static final BacktestDto mockRequest = BacktestDto(
    symbol: "BTCUSDT",
    usdt: 10000,
    interval: "1m",
    startDate: DateTime.parse("2024-10-17T02:00:00"),
    endDate: DateTime.parse("2024-11-16T02:00:00"),
    tc: -0.00085,
    leverage: 3,
    strategies: {
      "RSI": {
        "periods": 14,
        "rsi_upper": 70,
        "rsi_lower": 30
      },
      "SMA": {
        "sma_s": 5,
        "sma_m": 100,
        "sma_l": 180
      },
      "RV": {
        "return_thresh_low": -0.01,
        "return_thresh_high": 0.01,
        "volume_thresh_low": -0.5,
        "volume_thresh_high": 0.5
      }
    },
  );

  static final Map<String, dynamic> mockResponse = {
    "ok": true,
    "result": {
      "strategy_name": "RSI SMA ReturnVolume",
      "performance": {
        "sharpe": 1.265,
        "cstrategy": 1.0055,
        "b&h": 0.41,
        "cagr": 0.012,
        "ann_mean": 0.0119,
        "ann_std": 0.0094,
        "trades": 2,
        "initial_usdt": 10000,
        "final_usdt": 10055
      },
      "leverage_performance": {
        "leverage_applied": 3,
        "sharpe": 1.2636,
        "cstrategy": 1.0165,
        "cagr": 0.0361,
        "ann_mean": 0.0355,
        "ann_std": 0.0281,
        "final_usdt_levered": 10165
      },
      "uid": "001"
    }
  };

  static final List<String> mockSymbols = [
    'BTCUSDT',
    'ETCUSDT',
    'CTCUSDT',
    '1BTCUSDT',
    'B2TCUSDT',
    'BT3CUSDT',
    'BTC4USDT',
    'BTCU5SDT',
    'BTCUS6DT',
    'BTCUSD7T',
    'BTCUSDT8',
    'B1TCUSDT',
    'BT2CUSDT',
    'BTC3USDT',
    'BTCU4SDT',
    'BTCUS5DT',
    'BTCUSD6T',
    'BTCUSDT7',
    'B8TCUSDT',
    'BT9CUSDT',
  ];

  static final Map<String, Map<String, dynamic>> mockStrategies = {
    'RSI': {
      'parameters': {
        'periods': 14,
        'rsi_upper': 70,
        'rsi_lower': 30,
      },
    },
    'SMA': {
      'parameters': {
        'sma_s': 5,
        'sma_m': 100,
        'sma_l': 180,
      },
    },
    'RV': {
      'parameters': {
        'return_thresh_low': -0.01,
        'return_thresh_high': 0.01,
        'volume_thresh_low': -0.5,
        'volume_thresh_high': 0.5,
      },
    },
  };
}