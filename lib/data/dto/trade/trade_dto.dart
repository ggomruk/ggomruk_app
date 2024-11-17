import 'package:json_annotation/json_annotation.dart';

part 'trade_dto.g.dart';

@JsonSerializable()
class TradeDto {
  @JsonKey(name: 'task')
  final String task;

  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'params')
  final TradeParams params;

  TradeDto({
    this.task = 'trade',
    required this.uid,
    required this.params,
  });

  factory TradeDto.fromJson(Map<String, dynamic> json) =>
      _$TradeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TradeDtoToJson(this);
}

@JsonSerializable()
class TradeParams {
  @JsonKey(name: 'symbol')
  final String symbol;

  @JsonKey(name: 'interval')
  final String interval;

  @JsonKey(name: 'strategies')
  final Map<String, Map<String, dynamic>> strategies;

  TradeParams({
    required this.symbol,
    required this.interval,
    required this.strategies,
  });

  factory TradeParams.fromJson(Map<String, dynamic> json) =>
      _$TradeParamsFromJson(json);

  Map<String, dynamic> toJson() => _$TradeParamsToJson(this);
}

@JsonSerializable()
class TradePositionDto {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'position')
  final double position;

  @JsonKey(name: 'timestamp')
  final DateTime timestamp;

  TradePositionDto({
    required this.uid,
    required this.position,
    required this.timestamp,
  });

  factory TradePositionDto.fromJson(Map<String, dynamic> json) =>
      _$TradePositionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TradePositionDtoToJson(this);
}