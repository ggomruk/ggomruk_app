import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constant.dart';
import '../../../../data/dto/backtest/backtest_dto.dart';
import '../../../../domain/usecase/backtest/run_backtest_usecase.dart';
import '../../../../domain/repository/backtest_repository.dart';
import '../../../../domain/model/backtest/backtest_model.dart';
import '../../../../core/error/error_response.dart';

part 'backtest_event.dart';
part 'backtest_state.dart';

class BacktestBloc extends Bloc<BacktestEvent, BacktestState> {
  final BacktestRepository repository;

  BacktestBloc({required this.repository}) : super(const BacktestState()) {
    on<RunBacktest>(_onRunBacktest);
    on<ResetBacktest>(_onResetBacktest);
  }

  Future<void> _onRunBacktest(RunBacktest event, Emitter<BacktestState> emit) async {
    emit(state.copyWith(status: BlocState.loading));

    final usecase = RunBacktestUsecase(event.backtestDto.toBacktestParams());
    final result = await usecase(repository);

    result.when(
      success: (backtestModel) => emit(state.copyWith(
        status: BlocState.success,
        result: backtestModel,
      )),
      failure: (error) => emit(state.copyWith(
        status: BlocState.failure,
        error: error,
      )),
    );
  }

  void _onResetBacktest(ResetBacktest event, Emitter<BacktestState> emit) {
    emit(const BacktestState());
  }
}