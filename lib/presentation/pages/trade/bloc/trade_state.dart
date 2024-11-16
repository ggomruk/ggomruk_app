part of 'trade_bloc.dart';

class TradeState extends Equatable {
  final BlocState status;
  final TradeModel? trade;
  final ErrorResponse? error;
  final bool isTrading;

  const TradeState({
    this.status = BlocState.initial,
    this.trade,
    this.error,
    this.isTrading = false,
  });

  TradeState copyWith({
    BlocState? status,
    TradeModel? trade,
    ErrorResponse? error,
    bool? isTrading,
  }) {
    return TradeState(
      status: status ?? this.status,
      trade: trade ?? this.trade,
      error: error ?? this.error,
      isTrading: isTrading ?? this.isTrading,
    );
  }

  @override
  List<Object?> get props => [status, trade, error, isTrading];
}