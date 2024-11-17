import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/localization/app_localizations.dart';
import 'core/theme/theme_cubit.dart';
import 'data/mock/trade_mock_data.dart';
import 'domain/repository/trade_repository.dart';
import 'domain/usecase/trade/start_trade_usecase.dart';
import 'presentation/pages/backtest/bloc/backtest_bloc.dart';
import 'presentation/pages/backtest/bloc/form/backtest_form_bloc.dart';
import 'presentation/pages/trade/bloc/trade_bloc.dart';
import 'presentation/routes/routes.dart';
import 'service_locator.dart';
import 'domain/usecase/backtest/run_backtest_usecase.dart';
import 'data/mock/backtest_mock_data.dart';
import 'domain/repository/backtest_repository.dart';
import 'core/exceptions/common_exception.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setLocator();

  final backtestRepository = locator<BacktestRepository>();

  final runBacktestUsecase = RunBacktestUsecase(BacktestMockData.mockRequest.toJson());

  final tradeRepository = locator<TradeRepository>();
  final startTradeUsecase = StartTradeUsecase(
    symbol: TradeMockData.mockRequest.params.symbol,
    interval: TradeMockData.mockRequest.params.interval,
    strategies: TradeMockData.mockRequest.params.strategies,
    uid: TradeMockData.mockRequest.uid,
  );

  try {
    // Call the usecase
    final result = await runBacktestUsecase.call(backtestRepository);

    result.when(
      success: (backtestModel) {
        CustomLogger.logger.i('Backtest Repository Response:');
        CustomLogger.logger.i('Status: true');
        CustomLogger.logger.i('Code: SUCCESS');
        CustomLogger.logger.i('Message: Backtest completed successfully');
      },
      failure: (errorResponse) {
        CustomLogger.logger.e('Backtest Repository Response:');
        CustomLogger.logger.e('Status: ${errorResponse.status}');
        CustomLogger.logger.e('Code: ${errorResponse.code}');
        CustomLogger.logger.e('Message: ${errorResponse.message}');
      },
    );
  } catch (e) {
    if (e is CommonException) {
      final errorResponse = createErrorResponse(e);
      CustomLogger.logger.e('CommonException occurred:');
      CustomLogger.logger.e('Status: ${errorResponse.status}');
      CustomLogger.logger.e('Code: ${errorResponse.code}');
      CustomLogger.logger.e('Message: ${errorResponse.message}');
    } else {
      CustomLogger.logger.e('Unexpected error occurred', error: e);
    }
  }

  try {
    // Test trade mock
    final result = await startTradeUsecase(tradeRepository);

    result.when(
      success: (tradeModel) {
        CustomLogger.logger.i('Trade Repository Response:');
        CustomLogger.logger.i('Status: true');
        CustomLogger.logger.i('Code: SUCCESS');
        CustomLogger.logger.i('Message: Trade started successfully');
        CustomLogger.logger.i('Symbol: ${tradeModel.params.symbol}');
        CustomLogger.logger.i('Interval: ${tradeModel.params.interval}');
        CustomLogger.logger.i('Strategies: ${tradeModel.params.strategies}');
        CustomLogger.logger.i('UID: ${tradeModel.uid}');
      },
      failure: (errorResponse) {
        CustomLogger.logger.e('Trade Repository Response:');
        CustomLogger.logger.e('Status: ${errorResponse.status}');
        CustomLogger.logger.e('Code: ${errorResponse.code}');
        CustomLogger.logger.e('Message: ${errorResponse.message}');
      },
    );
  } catch (e) {
    if (e is CommonException) {
      final errorResponse = createErrorResponse(e);
      CustomLogger.logger.e('CommonException occurred:');
      CustomLogger.logger.e('Status: ${errorResponse.status}');
      CustomLogger.logger.e('Code: ${errorResponse.code}');
      CustomLogger.logger.e('Message: ${errorResponse.message}');
    } else {
      CustomLogger.logger.e('Unexpected error occurred', error: e);
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => locator<BacktestBloc>()),
        BlocProvider(create: (context) => locator<BacktestFormBloc>()),
        BlocProvider(create: (context) => locator<TradeBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            routerConfig: router,
            title: 'GGOMRUK QUANT',
            theme: theme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
