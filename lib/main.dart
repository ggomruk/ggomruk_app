import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/localization/app_localizations.dart';
import 'core/theme/theme_cubit.dart';
import 'presentation/pages/backtest/bloc/backtest_bloc.dart';
import 'presentation/routes/routes.dart';
import 'service_locator.dart';
import 'domain/usecase/backtest/run_backtest_usecase.dart';
import 'data/mock/backtest_mock_data.dart';
import 'domain/repository/backtest_repository.dart';
import 'core/exceptions/common_exception.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the service locator
  setLocator();

  // Get the BacktestRepository from the service locator
  final backtestRepository = locator<BacktestRepository>();

  // Create the RunBacktestUsecase with the mock request
  final runBacktestUsecase = RunBacktestUsecase(BacktestMockData.mockRequest.toJson());

  try {
    // Call the usecase
    final result = await runBacktestUsecase.call(backtestRepository);

    result.when(
      success: (backtestModel) {
        CustomLogger.logger.i('Backtest Repository Response:');
        CustomLogger.logger.i('Status: true');
        CustomLogger.logger.i('Code: SUCCESS');
        CustomLogger.logger.i('Message: Backtest completed successfully');
        CustomLogger.logger.i('Strategy Name: ${backtestModel.strategyName}');
        CustomLogger.logger.i('Performance - Sharpe: ${backtestModel.performance.sharpe}');
        CustomLogger.logger.i('Leverage Performance - CAGR: ${backtestModel.leveragePerformance.cagr}');
        CustomLogger.logger.i('UID: ${backtestModel.uid}');
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => locator<BacktestBloc>()),
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
