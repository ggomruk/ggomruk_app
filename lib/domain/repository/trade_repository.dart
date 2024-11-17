import '../../data/dto/common/response_wrapper/response_wrapper.dart';
import '../model/trade/trade_model.dart';
import 'repository.dart';

abstract class TradeRepository implements Repository {
  Future<ResponseWrapper<TradeModel>> startTrade(TradeModel model);
  Future<ResponseWrapper<void>> stopTrade(String uid);
  Stream<TradeModel> getPositionUpdates(String uid);
}