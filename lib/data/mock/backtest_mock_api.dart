import 'dart:async';
import '../data_source/remote/backtest/backtest_api_interface.dart';
import '../dto/backtest/backtest_dto.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import 'backtest_mock_data.dart';

class BacktestMockApiClient implements BacktestApiInterface {
  @override
  Future<ResponseWrapper<Map<String, dynamic>>> runBacktest(BacktestDto backtestDto) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final requestJson = backtestDto.toJson();
      final mockJson = BacktestMockData.mockRequest.toJson();

      bool isValid = requestJson['symbol'] == mockJson['symbol'] &&
          requestJson['interval'] == mockJson['interval'] &&
          requestJson['usdt'] == mockJson['usdt'] &&
          requestJson['leverage'] == mockJson['leverage'] &&
          requestJson['strategies'] != null &&
          (requestJson['strategies'] as Map).isNotEmpty;

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
      return _handleError(e);
    }
  }

  @override
  Future<ResponseWrapper<List<String>>> getAvailableSymbols() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return ResponseWrapper<List<String>>(
        status: true,
        code: 'SUCCESS',
        message: 'Symbols retrieved successfully',
        data: BacktestMockData.mockSymbols,
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseWrapper<Map<String, Map<String, dynamic>>>> getAvailableStrategies() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return ResponseWrapper<Map<String, Map<String, dynamic>>>(
        status: true,
        code: 'SUCCESS',
        message: 'Strategies retrieved successfully',
        data: BacktestMockData.mockStrategies,
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  ResponseWrapper<T> _handleError<T>(dynamic error) {
    if (error is FormatException) {
      return ResponseWrapper(
        status: false,
        code: 'FORMAT_ERROR',
        message: 'Invalid response format',
      );
    }
    return ResponseWrapper(
      status: false,
      code: 'UNEXPECTED_ERROR',
      message: error.toString(),
    );
  }
}