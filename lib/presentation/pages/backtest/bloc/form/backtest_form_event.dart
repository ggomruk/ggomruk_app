part of 'backtest_form_bloc.dart';

abstract class BacktestFormEvent extends Equatable {
  const BacktestFormEvent();

  @override
  List<Object?> get props => [];
}

class LoadFormData extends BacktestFormEvent {}

class UpdateBasicSettings extends BacktestFormEvent {
  final String? symbol;
  final double? usdt;
  final String? interval;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? tc;
  final int? leverage;

  const UpdateBasicSettings({
    this.symbol,
    this.usdt,
    this.interval,
    this.startDate,
    this.endDate,
    this.tc,
    this.leverage,
  });

  @override
  List<Object?> get props => [
    symbol,
    usdt,
    interval,
    startDate,
    endDate,
    tc,
    leverage,
  ];
}

class AddStrategy extends BacktestFormEvent {
  final String strategyName;
  final Map<String, dynamic> parameters;

  const AddStrategy(this.strategyName, this.parameters);

  @override
  List<Object> get props => [strategyName, parameters];
}

class RemoveStrategy extends BacktestFormEvent {
  final String strategyName;

  const RemoveStrategy(this.strategyName);

  @override
  List<Object> get props => [strategyName];
}

class ResetForm extends BacktestFormEvent {}