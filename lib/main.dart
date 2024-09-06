import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'core/localization/app_localizations.dart';
import 'core/theme/theme_cubit.dart';
import 'presentation/routes/routes.dart';
import 'service_locator.dart';
import 'domain/usecase/backtest/run_backtest_usecase.dart';
import 'data/mock/backtest_mock_data.dart';
import 'domain/repository/backtest_repository.dart';

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
        developer.log('Backtest Repository Response:', name: 'Main');
        developer.log('Status: true', name: 'Main');
        developer.log('Code: SUCCESS', name: 'Main');
        developer.log('Message: Backtest completed successfully', name: 'Main');
        developer.log('Strategy Name: ${backtestModel.strategyName}', name: 'Main');
        developer.log('Performance - Sharpe: ${backtestModel.performance.sharpe}', name: 'Main');
        developer.log('Leverage Performance - CAGR: ${backtestModel.leveragePerformance.cagr}', name: 'Main');
        developer.log('UID: ${backtestModel.uid}', name: 'Main');
      },
      failure: (errorResponse) {
        developer.log('Backtest Repository Response:', name: 'Main');
        developer.log('Status: false', name: 'Main');
        developer.log('Code: ${errorResponse.code}', name: 'Main');
        developer.log('Message: ${errorResponse.message}', name: 'Main');
      },
    );
  } catch (e) {
    developer.log('Unexpected error occurred: $e', name: 'Main', error: e);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
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