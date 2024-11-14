import '../../domain/repository/backtest_repository.dart';
import '../../domain/model/backtest/backtest_model.dart';
import '../data_source/remote/backtest_api_interface.dart';
import '../dto/backtest/backtest_dto.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import '../mapper/backtest_mapper.dart';

class BacktestRepositoryImpl implements BacktestRepository {
  final BacktestApiInterface apiClient;

  BacktestRepositoryImpl({required this.apiClient});

  @override
  Future<ResponseWrapper<BacktestModel>> runBacktest(Map<String, dynamic> params) async {
    try {
      final backtestDto = BacktestDto(
        symbol: params['symbol'] as String? ?? '',
        usdt: (params['usdt'] as num?)?.toDouble() ?? 0.0,
        interval: params['interval'] as String? ?? '',
        startDate: DateTime.parse(params['startDate'] as String? ?? ''),
        endDate: DateTime.parse(params['endDate'] as String? ?? ''),
        tc: (params['commission'] as num?)?.toDouble() ?? 0.0,
        leverage: (params['leverage'] as num?)?.toInt() ?? 1,
        strategies: (params['strategies'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, v as Map<String, dynamic>),
        ) ?? {},
      );

      final response = await apiClient.runBacktest(backtestDto);

      if (response.status && response.data != null) {
        final backtestModel = BacktestMapper.fromDto(response.data!);
        return ResponseWrapper<BacktestModel>(
            status: true,
            data: backtestModel,
            message: response.message,
            code: response.code
        );
      } else {
        return ResponseWrapper<BacktestModel>(
            status: false,
            message: response.message ?? 'Unknown error',
            code: response.code ?? 'UNKNOWN_ERROR'
        );
      }
    } catch (e, stackTrace) {
      print('Error in runBacktest: $e');
      print('Stack trace: $stackTrace');
      return ResponseWrapper<BacktestModel>(
          status: false,
          message: 'An unexpected error occurred: ${e.toString()}',
          code: 'UNEXPECTED_ERROR'
      );
    }
  }

  @override
  Future<ResponseWrapper<List<String>>> getAvailableSymbols() async {
    try {
      final response = await apiClient.getAvailableSymbols();

      if (response.status && response.data != null) {
        return ResponseWrapper<List<String>>(
            status: true,
            data: response.data,
            message: response.message,
            code: response.code
        );
      } else {
        return ResponseWrapper<List<String>>(
            status: false,
            message: response.message ?? 'Failed to fetch symbols',
            code: response.code ?? 'UNKNOWN_ERROR'
        );
      }
    } catch (e, stackTrace) {
      print('Error in getAvailableSymbols: $e');
      print('Stack trace: $stackTrace');
      return ResponseWrapper<List<String>>(
          status: false,
          message: 'An unexpected error occurred: ${e.toString()}',
          code: 'UNEXPECTED_ERROR'
      );
    }
  }

  @override
  Future<ResponseWrapper<Map<String, Map<String, dynamic>>>> getAvailableStrategies() async {
    try {
      final response = await apiClient.getAvailableStrategies();

      if (response.status && response.data != null) {
        return ResponseWrapper<Map<String, Map<String, dynamic>>>(
            status: true,
            data: response.data,
            message: response.message,
            code: response.code
        );
      } else {
        return ResponseWrapper<Map<String, Map<String, dynamic>>>(
            status: false,
            message: response.message ?? 'Failed to fetch strategies',
            code: response.code ?? 'UNKNOWN_ERROR'
        );
      }
    } catch (e, stackTrace) {
      print('Error in getAvailableStrategies: $e');
      print('Stack trace: $stackTrace');
      return ResponseWrapper<Map<String, Map<String, dynamic>>>(
          status: false,
          message: 'An unexpected error occurred: ${e.toString()}',
          code: 'UNEXPECTED_ERROR'
      );
    }
  }
}