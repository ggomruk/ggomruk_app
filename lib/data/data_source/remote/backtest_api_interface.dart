import '../../dto/backtest/backtest_dto.dart';
import '../../dto/common/response_wrapper/response_wrapper.dart';

abstract class BacktestApiInterface {
  Future<ResponseWrapper<Map<String, dynamic>>> runBacktest(BacktestDto backtestDto);
}