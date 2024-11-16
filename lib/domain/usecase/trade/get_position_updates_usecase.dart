import '../../repository/trade_repository.dart';
import '../../model/trade/trade_model.dart';
import '../base/remote_usecase.dart';

class GetPositionUpdatesUsecase implements StreamUsecase<TradeRepository> {
  final String uid;

  GetPositionUpdatesUsecase(this.uid);

  @override
  Stream<TradeModel> call(TradeRepository repository) {
    return repository.getPositionUpdates(uid);
  }
}