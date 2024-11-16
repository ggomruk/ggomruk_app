// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeDto _$TradeDtoFromJson(Map<String, dynamic> json) => TradeDto(
      task: json['task'] as String? ?? 'trade',
      uid: json['uid'] as String,
      params: TradeParams.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TradeDtoToJson(TradeDto instance) => <String, dynamic>{
      'task': instance.task,
      'uid': instance.uid,
      'params': instance.params,
    };

TradeParams _$TradeParamsFromJson(Map<String, dynamic> json) => TradeParams(
      symbol: json['symbol'] as String,
      interval: json['interval'] as String,
      strategies: (json['strategies'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
    );

Map<String, dynamic> _$TradeParamsToJson(TradeParams instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'interval': instance.interval,
      'strategies': instance.strategies,
    };

TradePositionDto _$TradePositionDtoFromJson(Map<String, dynamic> json) =>
    TradePositionDto(
      uid: json['uid'] as String,
      position: (json['position'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$TradePositionDtoToJson(TradePositionDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'position': instance.position,
      'timestamp': instance.timestamp.toIso8601String(),
    };
