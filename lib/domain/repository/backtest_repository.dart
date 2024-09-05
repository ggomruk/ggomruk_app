import '../../data/dto/common/response_wrapper/response_wrapper.dart';
import '../model/backtest/backtest_model.dart';

abstract class BacktestRepository {
  Future<ResponseWrapper<BacktestModel>> runBacktest(Map<String, dynamic> params);
}