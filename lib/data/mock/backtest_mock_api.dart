import 'dart:async';
import '../dto/backtest/backtest_dto.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import '../data_source/remote/backtest_api_interface.dart';
import 'backtest_mock_data.dart';

class BacktestMockApiClient implements BacktestApiInterface {
  @override
  Future<ResponseWrapper<Map<String, dynamic>>> runBacktest(BacktestDto backtestDto) async {
    await Future.delayed(Duration(seconds: 2));

    try {
      final requestJson = backtestDto.toJson();
      final mockJson = BacktestMockData.mockRequest.toJson();

      bool isValid =
          requestJson['symbol'] == mockJson['symbol'] &&
              requestJson['interval'] == mockJson['interval'] &&
              requestJson['usdt'] == mockJson['usdt'] &&
              requestJson['leverage'] == mockJson['leverage'];

      if (isValid) {
        return ResponseWrapper<Map<String, dynamic>>(
          status: true,
          code: 'SUCCESS',
          message: 'Backtest completed successfully',
          data: BacktestMockData.mockResponse['result'],
        );
      } else {
        return ResponseWrapper(
          status: false,
          code: 'INVALID_INPUT',
          message: 'Invalid input parameters',
        );
      }
    } catch (e) {
      return ResponseWrapper(
        status: false,
        code: 'UNEXPECTED_ERROR',
        message: e.toString(),
      );
    }
  }
}