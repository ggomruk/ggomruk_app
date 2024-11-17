import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/repository/backtest_repository.dart';
import '../../../../../domain/usecase/backtest/get_strategies_usecase.dart';
import '../../../../../domain/usecase/backtest/get_symbols_usecase.dart';

part 'backtest_form_event.dart';
part 'backtest_form_state.dart';

class BacktestFormBloc extends Bloc<BacktestFormEvent, BacktestFormState> {
  final BacktestRepository repository;

  BacktestFormBloc({required this.repository}) : super(BacktestFormState.initial()) {
    on<LoadFormData>(_onLoadFormData);
    on<UpdateBasicSettings>(_onUpdateBasicSettings);
    on<AddStrategy>(_onAddStrategy);
    on<RemoveStrategy>(_onRemoveStrategy);
    on<ResetForm>(_onResetForm);
  }

  Future<void> _onLoadFormData(LoadFormData event, Emitter<BacktestFormState> emit) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      final symbolsResult = await GetSymbolsUsecase()(repository);
      final strategiesResult = await GetStrategiesUsecase()(repository);

      final symbols = symbolsResult.when(
        success: (data) => data,
        failure: (_) => <String>[],
      );

      final strategies = strategiesResult.when(
        success: (data) => data,
        failure: (_) => <String, Map<String, dynamic>>{},
      );

      emit(state.copyWith(
        status: FormStatus.loaded,
        availableSymbols: symbols,
        availableStrategies: strategies,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onUpdateBasicSettings(UpdateBasicSettings event, Emitter<BacktestFormState> emit) {
    emit(state.copyWith(
      symbol: event.symbol,
      usdt: event.usdt,
      interval: event.interval,
      startDate: event.startDate,
      endDate: event.endDate,
      tc: event.tc,
      leverage: event.leverage,
    ));
  }

  void _onAddStrategy(AddStrategy event, Emitter<BacktestFormState> emit) {
    final updatedStrategies = Map<String, Map<String, dynamic>>.from(state.strategies);
    updatedStrategies[event.strategyName] = event.parameters;
    emit(state.copyWith(strategies: updatedStrategies));
  }

  void _onRemoveStrategy(RemoveStrategy event, Emitter<BacktestFormState> emit) {
    final updatedStrategies = Map<String, Map<String, dynamic>>.from(state.strategies);
    updatedStrategies.remove(event.strategyName);
    emit(state.copyWith(strategies: updatedStrategies));
  }

  void _onResetForm(ResetForm event, Emitter<BacktestFormState> emit) {
    emit(BacktestFormState.initial());
  }
}
