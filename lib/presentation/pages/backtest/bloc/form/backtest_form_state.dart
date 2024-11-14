part of 'backtest_form_bloc.dart';

enum FormStatus { initial, loading, loaded, error }

class BacktestFormState extends Equatable {
  final FormStatus status;
  final List<String> availableSymbols;
  final Map<String, Map<String, dynamic>> availableStrategies;
  final String? errorMessage;
  final String symbol;
  final double usdt;
  final String interval;
  final DateTime? startDate;
  final DateTime? endDate;
  final double tc;
  final int leverage;
  final Map<String, Map<String, dynamic>> strategies;

  const BacktestFormState({
    this.status = FormStatus.initial,
    this.availableSymbols = const [],
    this.availableStrategies = const {},
    this.errorMessage,
    this.symbol = 'BTCUSDT',
    this.usdt = 10000,
    this.interval = '1m',
    this.startDate,
    this.endDate,
    this.tc = -0.00085,
    this.leverage = 1,
    this.strategies = const {},
  });

  factory BacktestFormState.initial() {
    final now = DateTime.now();
    return BacktestFormState(
      startDate: now.subtract(const Duration(days: 30)),
      endDate: now,
    );
  }


  BacktestFormState copyWith({
    FormStatus? status,
    List<String>? availableSymbols,
    Map<String, Map<String, dynamic>>? availableStrategies,
    String? errorMessage,
    String? symbol,
    double? usdt,
    String? interval,
    DateTime? startDate,
    DateTime? endDate,
    double? tc,
    int? leverage,
    Map<String, Map<String, dynamic>>? strategies,
  }) {
    return BacktestFormState(
      status: status ?? this.status,
      availableSymbols: availableSymbols ?? this.availableSymbols,
      availableStrategies: availableStrategies ?? this.availableStrategies,
      errorMessage: errorMessage ?? this.errorMessage,
      symbol: symbol ?? this.symbol,
      usdt: usdt ?? this.usdt,
      interval: interval ?? this.interval,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tc: tc ?? this.tc,
      leverage: leverage ?? this.leverage,
      strategies: strategies ?? this.strategies,
    );
  }

  @override
  List<Object?> get props => [
    status,
    availableSymbols,
    availableStrategies,
    errorMessage,
    symbol,
    usdt,
    interval,
    startDate,
    endDate,
    tc,
    leverage,
    strategies,
  ];
}