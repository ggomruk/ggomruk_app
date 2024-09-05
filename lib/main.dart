import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'core/localization/app_localizations.dart';
import 'core/theme/theme_cubit.dart';
import 'data/data_source/remote/backtest_api_interface.dart';
import 'presentation/routes/routes.dart';

import 'data/mock/backtest_mock_api.dart';
import 'data/mock/backtest_mock_data.dart';
import 'data/repository_impl/backtest_repository_impl.dart';
import 'domain/model/backtest/backtest_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of BacktestMockApiClient
  final BacktestApiInterface apiClient = BacktestMockApiClient();
  final backtestRepository = BacktestRepositoryImpl(apiClient: apiClient);

  // Use the mock request data
  final mockRequest = BacktestMockData.mockRequest.toJson();

  try {
    // Call the repository method
    final response = await backtestRepository.runBacktest(mockRequest);

    // Log the response
    developer.log('Backtest Repository Response:', name: 'Main');
    developer.log('Status: ${response.status}', name: 'Main');
    developer.log('Code: ${response.code}', name: 'Main');
    developer.log('Message: ${response.message}', name: 'Main');

    if (response.status && response.data != null) {
      final BacktestModel data = response.data!;
      developer.log('Strategy Name: ${data.strategyName}', name: 'Main');
      developer.log('Performance - Sharpe: ${data.performance.sharpe}', name: 'Main');
      developer.log('Leverage Performance - CAGR: ${data.leveragePerformance.cagr}', name: 'Main');
      developer.log('UID: ${data.uid}', name: 'Main');
    } else {
      developer.log('No data available', name: 'Main');
    }
  } catch (e) {
    developer.log('Error occurred: $e', name: 'Main', error: e);
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