import '../../domain/model/backtest/backtest_model.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import 'common_mapper.dart';

class BacktestMapper {
  static BacktestModel fromDto(Map<String, dynamic> json) {
    return BacktestModel(
      strategyName: json['strategy_name'],
      performance: Performance(
        sharpe: (json['performance']['sharpe'] as num).toDouble(),
        cstrategy: (json['performance']['cstrategy'] as num).toDouble(),
        bAndH: (json['performance']['b&h'] as num).toDouble(),
        cagr: (json['performance']['cagr'] as num).toDouble(),
        annMean: (json['performance']['ann_mean'] as num).toDouble(),
        annStd: (json['performance']['ann_std'] as num).toDouble(),
        trades: json['performance']['trades'] as int,
        initialUsdt: (json['performance']['initial_usdt'] as num).toDouble(),
        finalUsdt: (json['performance']['final_usdt'] as num).toDouble(),
      ),
      leveragePerformance: LeveragePerformance(
        leverageApplied: json['leverage_performance']['leverage_applied'] as int,
        sharpe: (json['leverage_performance']['sharpe'] as num).toDouble(),
        cstrategy: (json['leverage_performance']['cstrategy'] as num).toDouble(),
        cagr: (json['leverage_performance']['cagr'] as num).toDouble(),
        annMean: (json['leverage_performance']['ann_mean'] as num).toDouble(),
        annStd: (json['leverage_performance']['ann_std'] as num).toDouble(),
        finalUsdtLevered: (json['leverage_performance']['final_usdt_levered'] as num).toDouble(),
      ),
      uid: json['uid'],
    );
  }

  static BacktestModel fromResponse(ResponseWrapper<Map<String, dynamic>> response) {
    return CommonMapper.mapResponseToModel(response, fromDto);
  }
}