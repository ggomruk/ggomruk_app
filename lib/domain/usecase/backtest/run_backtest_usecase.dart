import '../../../core/error/error_response.dart';
import '../base/remote_usecase.dart';
import '../../repository/backtest_repository.dart';
import '../../model/common/result.dart';
import '../../model/backtest/backtest_model.dart';

class RunBacktestUsecase implements RemoteUsecase<BacktestRepository> {
  final Map<String, dynamic> params;

  RunBacktestUsecase(this.params);

  @override
  Future<Result<BacktestModel>> call(BacktestRepository repository) async {
    try {
      final response = await repository.runBacktest(params);
      if (response.status && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ErrorResponse(
          status: 'FAILURE',
          code: response.code ?? 'UNKNOWN_ERROR',
          message: response.message ?? 'Unknown error occurred',
        ));
      }
    } catch (e) {
      return Failure(ErrorResponse(
        status: 'ERROR',
        code: 'UNEXPECTED_ERROR',
        message: e.toString(),
      ));
    }
  }
}