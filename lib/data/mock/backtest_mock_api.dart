import 'dart:async';
import '../dto/backtest_dto.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import 'backtest_mock_data.dart';

class BacktestMockApiClient {
  Future<ResponseWrapper<Map<String, dynamic>>> runBacktest(BacktestDto backtestDto) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Check if the input matches the mock request
    if (backtestDto.toJson().toString() == BacktestMockData.mockRequest.toJson().toString()) {
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
  }
}