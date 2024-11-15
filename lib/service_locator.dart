import 'package:get_it/get_it.dart';

import 'data/data_source/remote/backtest_api.dart';
import 'data/data_source/remote/backtest_api_interface.dart';
import 'data/mock/backtest_mock_api.dart';
import 'data/repository_impl/backtest_repository_impl.dart';
import 'domain/repository/backtest_repository.dart';
import 'domain/usecase/backtest/run_backtest_usecase.dart';
import 'presentation/pages/backtest/bloc/backtest_bloc.dart';
import 'presentation/pages/backtest/bloc/form/backtest_form_bloc.dart';

final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
  _presentation();
}

void _data() {
  locator.registerSingleton<BacktestApiInterface>(BacktestMockApiClient());
}

void _domain() {
  // Repository
  locator.registerSingleton<BacktestRepository>(
    BacktestRepositoryImpl(apiClient: locator<BacktestApiInterface>()),
  );

  // Usecase
  locator.registerFactory<RunBacktestUsecase>(
        () => RunBacktestUsecase({}),
  );
}

void _presentation() {
  // Bloc
  locator.registerFactory<BacktestBloc>(
        () => BacktestBloc(repository: locator<BacktestRepository>()),
  );

  locator.registerFactory<BacktestFormBloc>(
        () => BacktestFormBloc(repository: locator<BacktestRepository>()),
  );
}