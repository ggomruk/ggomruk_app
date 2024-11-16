import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constant.dart';
import '../../../../domain/repository/trade_repository.dart';
import '../../../../domain/usecase/trade/start_trade_usecase.dart';
import '../../../../domain/usecase/trade/stop_trade_usecase.dart';
import '../../../../domain/usecase/trade/get_position_updates_usecase.dart';
import '../../../../domain/model/trade/trade_model.dart';
import '../../../../core/error/error_response.dart';

part 'trade_event.dart';
part 'trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  final TradeRepository _repository;
  StreamSubscription<TradeModel>? _positionSubscription;

  TradeBloc({
    required TradeRepository repository,
  }) : _repository = repository,
        super(const TradeState()) {
    on<StartTrade>(_onStartTrade);
    on<StopTrade>(_onStopTrade);
    on<UpdatePosition>(_onUpdatePosition);
  }

  Future<void> _onStartTrade(StartTrade event, Emitter<TradeState> emit) async {
    try {
      emit(state.copyWith(status: BlocState.loading));

      final usecase = StartTradeUsecase(
        symbol: event.symbol,
        interval: event.interval,
        strategies: event.strategies,
        uid: event.uid,
      );

      final result = await usecase(_repository);

      result.when(
        success: (tradeModel) {
          _setupPositionUpdates(tradeModel.uid);
          emit(state.copyWith(
            status: BlocState.success,
            trade: tradeModel,
            isTrading: true,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            status: BlocState.failure,
            error: error,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: BlocState.failure,
        error: ErrorResponse(
          status: 'ERROR',
          code: 'UNEXPECTED_ERROR',
          message: e.toString(),
        ),
      ));
    }
  }

  Future<void> _onStopTrade(StopTrade event, Emitter<TradeState> emit) async {
    if (state.trade == null) return;

    try {
      emit(state.copyWith(status: BlocState.loading));

      final usecase = StopTradeUsecase(state.trade!.uid);
      final result = await usecase(_repository);

      await _positionSubscription?.cancel();
      _positionSubscription = null;

      result.when(
        success: (_) {
          emit(state.copyWith(
            status: BlocState.success,
            isTrading: false,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            status: BlocState.failure,
            error: error,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: BlocState.failure,
        error: ErrorResponse(
          status: 'ERROR',
          code: 'UNEXPECTED_ERROR',
          message: e.toString(),
        ),
      ));
    }
  }

  void _onUpdatePosition(UpdatePosition event, Emitter<TradeState> emit) {
    if (state.trade != null) {
      emit(state.copyWith(
        trade: state.trade!.copyWith(
          position: event.position,
        ),
      ));
    }
  }

  void _setupPositionUpdates(String uid) {
    _positionSubscription?.cancel();
    final usecase = GetPositionUpdatesUsecase(uid);
    _positionSubscription = usecase(_repository)
        .listen((model) => add(UpdatePosition(model.position)));
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
