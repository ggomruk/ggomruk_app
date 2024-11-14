import '../../data/dto/common/response_wrapper/response_wrapper.dart';
import '../model/backtest/backtest_model.dart';
import 'repository.dart';

abstract class BacktestRepository implements Repository {
  Future<ResponseWrapper<BacktestModel>> runBacktest(Map<String, dynamic> params);
  Future<ResponseWrapper<List<String>>> getAvailableSymbols();
  Future<ResponseWrapper<Map<String, Map<String, dynamic>>>> getAvailableStrategies();
}