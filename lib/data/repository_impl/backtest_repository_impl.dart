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
      final backtestDto = BacktestDto.fromJson(params);
      final response = await apiClient.runBacktest(backtestDto);

      if (response.status) {
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
            message: response.message,
            code: response.code
        );
      }
    } catch (e) {
      return ResponseWrapper<BacktestModel>(
          status: false,
          message: 'An unexpected error occurred',
          code: 'UNEXPECTED_ERROR'
      );
    }
  }
}