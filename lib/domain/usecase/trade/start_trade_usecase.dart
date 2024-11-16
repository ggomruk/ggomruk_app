import '../../../core/error/error_response.dart';
import '../base/remote_usecase.dart';
import '../../repository/trade_repository.dart';
import '../../model/common/result.dart';
import '../../model/trade/trade_model.dart';

class StartTradeUsecase implements RemoteUsecase<TradeRepository> {
  final String symbol;
  final String interval;
  final Map<String, Map<String, dynamic>> strategies;
  final String uid;

  StartTradeUsecase({
    required this.symbol,
    required this.interval,
    required this.strategies,
    required this.uid,
  });

  @override
  Future<Result<TradeModel>> call(TradeRepository repository) async {
    try {
      final tradeModel = TradeModel(
        task: 'trade',
        uid: uid,
        params: TradeParamsModel(
          symbol: symbol,
          interval: interval,
          strategies: strategies,
        ),
      );

      final response = await repository.startTrade(tradeModel);
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