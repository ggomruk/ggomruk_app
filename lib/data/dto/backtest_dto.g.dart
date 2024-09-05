// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backtest_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BacktestDto _$BacktestDtoFromJson(Map<String, dynamic> json) => BacktestDto(
      symbol: json['symbol'] as String,
      usdt: (json['usdt'] as num).toDouble(),
      interval: json['interval'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      tc: (json['tc'] as num).toDouble(),
      leverage: (json['leverage'] as num).toInt(),
      strategies: (json['strategies'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
    );

Map<String, dynamic> _$BacktestDtoToJson(BacktestDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'usdt': instance.usdt,
      'interval': instance.interval,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'tc': instance.tc,
      'leverage': instance.leverage,
      'strategies': instance.strategies,
    };
