import 'package:json_annotation/json_annotation.dart';

part 'backtest_dto.g.dart';

@JsonSerializable()
class BacktestDto {
  @JsonKey(name: 'symbol')
  final String symbol;

  @JsonKey(name: 'usdt')
  final double usdt;

  @JsonKey(name: 'interval')
  final String interval;

  @JsonKey(name: 'startDate')
  final DateTime startDate;

  @JsonKey(name: 'endDate')
  final DateTime endDate;

  @JsonKey(name: 'tc')
  final double tc;

  @JsonKey(name: 'leverage')
  final int leverage;

  @JsonKey(name: 'strategies')
  final Map<String, Map<String, dynamic>> strategies;

  BacktestDto({
    required this.symbol,
    required this.usdt,
    required this.interval,
    required this.startDate,
    required this.endDate,
    required this.tc,
    required this.leverage,
    required this.strategies,
  });

  factory BacktestDto.fromJson(Map<String, dynamic> json) =>
      _$BacktestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BacktestDtoToJson(this);

  Map<String, dynamic> toBacktestParams() {
    Map<String, dynamic> lowercaseStrategies = {};
    strategies.forEach((key, value) {
      lowercaseStrategies[key.toLowerCase()] = value;
    });

    return {
      'symbol': symbol,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'commission': tc,
      'usdt': usdt,
      'leverage': leverage,
      'interval': interval,
      'strategies': lowercaseStrategies,
    };
  }
}