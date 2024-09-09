part of 'backtest_bloc.dart';

class BacktestState extends Equatable {
  final BlocState status;
  final BacktestModel? result;
  final ErrorResponse? error;

  const BacktestState({
    this.status = BlocState.initial,
    this.result,
    this.error,
  });

  BacktestState copyWith({
    BlocState? status,
    BacktestModel? result,
    ErrorResponse? error,
  }) {
    return BacktestState(
      status: status ?? this.status,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, result, error];
}