import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'core/localization/app_localizations.dart';
import 'core/theme/theme_cubit.dart';
import 'presentation/routes/routes.dart';

// Import the necessary files
import 'data/mock/backtest_mock_api.dart';
import 'data/mock/backtest_mock_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of BacktestMockApiClient
  final mockApiClient = BacktestMockApiClient();

  // Use the mock request data
  final mockRequest = BacktestMockData.mockRequest;

  try {
    // Call the mock API
    final response = await mockApiClient.runBacktest(mockRequest);

    // Log the response
    developer.log('Mock API Response:', name: 'Main');
    developer.log('Status: ${response.status}', name: 'Main');
    developer.log('Code: ${response.code}', name: 'Main');
    developer.log('Message: ${response.message}', name: 'Main');
    developer.log('Data: ${response.data}', name: 'Main');
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