import 'package:get_it/get_it.dart';

import 'data/data_source/remote/backtest/backtest_api_interface.dart';
import 'data/data_source/remote/trade/trade_api_interface.dart';
import 'data/mock/backtest_mock_api.dart';
import 'data/mock/trade_mock_api.dart';
import 'data/mock/trade_mock_data.dart';
import 'data/repository_impl/backtest_repository_impl.dart';
import 'data/repository_impl/trade_repository_impl.dart';
import 'domain/repository/backtest_repository.dart';
import 'domain/repository/trade_repository.dart';
import 'domain/usecase/backtest/run_backtest_usecase.dart';
import 'domain/usecase/trade/start_trade_usecase.dart';
import 'domain/usecase/trade/stop_trade_usecase.dart';
import 'presentation/pages/backtest/bloc/backtest_bloc.dart';
import 'presentation/pages/backtest/bloc/form/backtest_form_bloc.dart';
import 'presentation/pages/trade/bloc/trade_bloc.dart';

final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
  _presentation();
}

void _data() {
  locator.registerSingleton<BacktestApiInterface>(BacktestMockApiClient());

  locator.registerSingleton<TradeApiInterface>(TradeMockApiClient());
}

void _domain() {
  locator.registerSingleton<BacktestRepository>(
    BacktestRepositoryImpl(apiClient: locator<BacktestApiInterface>()),
  );

  locator.registerFactory<RunBacktestUsecase>(
        () => RunBacktestUsecase({}),
  );

  locator.registerSingleton<TradeRepository>(
    TradeRepositoryImpl(locator<TradeApiInterface>()),
  );

  locator.registerFactory<StartTradeUsecase>(
        () => StartTradeUsecase(
      symbol: TradeMockData.mockRequest.params.symbol,
      interval: TradeMockData.mockRequest.params.interval,
      strategies: TradeMockData.mockRequest.params.strategies,
      uid: TradeMockData.mockRequest.uid,
    ),
  );

  locator.registerFactory<StopTradeUsecase>(
        () => StopTradeUsecase(''),
  );
}

void _presentation() {
  locator.registerFactory<BacktestBloc>(
        () => BacktestBloc(repository: locator<BacktestRepository>()),
  );

  locator.registerFactory<BacktestFormBloc>(
        () => BacktestFormBloc(repository: locator<BacktestRepository>()),
  );

  locator.registerFactory<TradeBloc>(
        () => TradeBloc(repository: locator<TradeRepository>()),
  );
}

