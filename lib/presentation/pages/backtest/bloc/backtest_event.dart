part of 'backtest_bloc.dart';

abstract class BacktestEvent extends Equatable {
  const BacktestEvent();

  @override
  List<Object> get props => [];
}

class RunBacktest extends BacktestEvent {
  final BacktestDto backtestDto;

  const RunBacktest(this.backtestDto);

  @override
  List<Object> get props => [backtestDto];
}

class ResetBacktest extends BacktestEvent {}