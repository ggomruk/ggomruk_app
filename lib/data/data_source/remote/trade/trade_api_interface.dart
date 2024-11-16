import '../../../dto/common/response_wrapper/response_wrapper.dart';
import '../../../dto/trade/trade_dto.dart';

abstract class TradeApiInterface {
  Future<ResponseWrapper<Map<String, dynamic>>> startTrade(TradeDto tradeDto);
  Future<ResponseWrapper<void>> stopTrade(String uid);
  Stream<TradePositionDto> getPositionUpdates(String uid);
}