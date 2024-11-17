import '../../../core/error/error_response.dart';
import '../../model/common/result.dart';
import '../../repository/backtest_repository.dart';
import '../base/remote_usecase.dart';

class GetStrategiesUsecase implements RemoteUsecase<BacktestRepository> {
  @override
  Future<Result<Map<String, Map<String, dynamic>>>> call(BacktestRepository repository) async {
    try {
      final response = await repository.getAvailableStrategies();
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