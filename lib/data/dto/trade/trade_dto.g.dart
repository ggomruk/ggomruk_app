// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeDto _$TradeDtoFromJson(Map<String, dynamic> json) => TradeDto(
      symbol: json['symbol'] as String,
      interval: json['interval'] as String,
      strategies: (json['strategies'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$TradeDtoToJson(TradeDto instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'interval': instance.interval,
      'strategies': instance.strategies,
      'uid': instance.uid,
    };

TradePositionDto _$TradePositionDtoFromJson(Map<String, dynamic> json) =>
    TradePositionDto(
      uid: json['uid'] as String,
      position: (json['position'] as num).toDouble(),
    );

Map<String, dynamic> _$TradePositionDtoToJson(TradePositionDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'position': instance.position,
    };
