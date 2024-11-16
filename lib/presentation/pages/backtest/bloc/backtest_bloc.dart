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
    on<HideBacktestResult>(_onHideBacktestResult); // 새로운 이벤트 핸들러
  }

  Future<void> _onRunBacktest(RunBacktest event, Emitter<BacktestState> emit) async {
    try {
      emit(state.copyWith(status: BlocState.loading));

      final params = event.backtestDto.toBacktestParams();
      final usecase = RunBacktestUsecase(params);
      final result = await usecase(repository);

      result.when(
        success: (backtestModel) {
          emit(state.copyWith(
            status: BlocState.success,
            result: backtestModel,
            showResult: true, // 결과가 준비되면 모달을 보여주도록 설정
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

  void _onHideBacktestResult(HideBacktestResult event, Emitter<BacktestState> emit) {
    // 모달을 숨기되 결과는 유지
    emit(state.copyWith(showResult: false));
  }

  void _onResetBacktest(ResetBacktest event, Emitter<BacktestState> emit) {
    emit(const BacktestState());
  }
}