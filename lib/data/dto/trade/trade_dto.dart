import 'package:json_annotation/json_annotation.dart';

part 'trade_dto.g.dart';

@JsonSerializable()
class TradeDto {
  @JsonKey(name: 'symbol')
  final String symbol;

  @JsonKey(name: 'interval')
  final String interval;

  @JsonKey(name: 'strategies')
  final Map<String, Map<String, dynamic>> strategies;

  @JsonKey(name: 'uid')
  final String uid;

  TradeDto({
    required this.symbol,
    required this.interval,
    required this.strategies,
    required this.uid,
  });

  factory TradeDto.fromJson(Map<String, dynamic> json) =>
      _$TradeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TradeDtoToJson(this);

  Map<String, dynamic> toTradeParams() {
    Map<String, dynamic> lowercaseStrategies = {};
    strategies.forEach((key, value) {
      lowercaseStrategies[key.toLowerCase()] = value;
    });

    return {
      'symbol': symbol,
      'interval': interval,
      'strategies': lowercaseStrategies,
    };
  }
}

@JsonSerializable()
class TradePositionDto {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'position')
  final double position;

  TradePositionDto({
    required this.uid,
    required this.position,
  });

  factory TradePositionDto.fromJson(Map<String, dynamic> json) =>
      _$TradePositionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TradePositionDtoToJson(this);
}