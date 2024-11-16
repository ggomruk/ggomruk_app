import '../data_source/remote/trade/trade_api_interface.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import '../dto/trade/trade_dto.dart';
import '../../domain/repository/trade_repository.dart';
import '../../domain/model/trade/trade_model.dart';

class TradeRepositoryImpl implements TradeRepository {
  final TradeApiInterface apiClient;
  TradeModel? _currentTradeModel;

  TradeRepositoryImpl(this.apiClient);

  @override
  Future<ResponseWrapper<TradeModel>> startTrade(TradeModel model) async {
    try {
      final tradeDto = TradeDto(
        task: model.task,
        uid: model.uid,
        params: TradeParams(
          symbol: model.params.symbol,
          interval: model.params.interval,
          strategies: model.params.strategies,
        ),
      );

      final response = await apiClient.startTrade(tradeDto);
      if (response.status && response.data != null) {
        _currentTradeModel = model.copyWith(isTrading: true);  // 현재 모델 저장
        return ResponseWrapper<TradeModel>(
          status: true,
          code: response.code,
          message: response.message,
          data: _currentTradeModel,
        );
      } else {
        return ResponseWrapper(
          status: false,
          code: response.code,
          message: response.message,
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


  @override
  Stream<TradeModel> getPositionUpdates(String uid) {
    return apiClient.getPositionUpdates(uid).map((positionDto) {
      // 현재 trade 상태 유지를 위해 기존 model을 복사하고 position만 업데이트
      final currentModel = _currentTradeModel; // _currentTradeModel을 클래스 변수로 추가
      if (currentModel == null) return TradeModel(
        uid: positionDto.uid,
        params: TradeParamsModel(
          symbol: "",
          interval: "",
          strategies: {},
        ),
        position: positionDto.position,
      );

      return currentModel.copyWith(
        position: positionDto.position,
      );
    });
  }


  @override
  Future<ResponseWrapper<void>> stopTrade(String uid) async {
    final response = await apiClient.stopTrade(uid);
    _currentTradeModel = null;  // 트레이딩 종료 시 현재 모델 초기화
    return response;
  }
}