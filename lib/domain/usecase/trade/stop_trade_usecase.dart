import '../../../core/error/error_response.dart';
import '../base/remote_usecase.dart';
import '../../repository/trade_repository.dart';
import '../../model/common/result.dart';

class StopTradeUsecase implements RemoteUsecase<TradeRepository> {
  final String uid;

  StopTradeUsecase(this.uid);

  @override
  Future<Result<void>> call(TradeRepository repository) async {
    try {
      final response = await repository.stopTrade(uid);
      if (response.status) {
        return const Success(null);
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