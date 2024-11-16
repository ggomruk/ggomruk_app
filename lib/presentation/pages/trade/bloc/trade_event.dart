part of 'trade_bloc.dart';

abstract class TradeEvent extends Equatable {
  const TradeEvent();

  @override
  List<Object> get props => [];
}

class StartTrade extends TradeEvent {
  final String symbol;
  final String interval;
  final Map<String, Map<String, dynamic>> strategies;
  final String uid;

  const StartTrade({
    required this.symbol,
    required this.interval,
    required this.strategies,
    required this.uid,
  });

  @override
  List<Object> get props => [symbol, interval, strategies, uid];
}

class StopTrade extends TradeEvent {}

class UpdatePosition extends TradeEvent {
  final double position;

  const UpdatePosition(this.position);

  @override
  List<Object> get props => [position];
}
