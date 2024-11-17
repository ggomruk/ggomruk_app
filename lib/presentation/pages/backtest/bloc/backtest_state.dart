part of 'backtest_bloc.dart';

class BacktestState extends Equatable {
  final BlocState status;
  final BacktestModel? result;
  final ErrorResponse? error;
  final bool showResult;
  final bool isFormLoaded;

  const BacktestState({
    this.status = BlocState.initial,
    this.result,
    this.error,
    this.showResult = false,
    this.isFormLoaded = false,
  });

  BacktestState copyWith({
    BlocState? status,
    BacktestModel? result,
    ErrorResponse? error,
    bool? showResult,
    bool? isFormLoaded,
  }) {
    return BacktestState(
      status: status ?? this.status,
      result: result ?? this.result,
      error: error ?? this.error,
      showResult: showResult ?? this.showResult,
      isFormLoaded: isFormLoaded ?? this.isFormLoaded,
    );
  }

  @override
  List<Object?> get props => [status, result, error, showResult, isFormLoaded];
}