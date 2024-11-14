import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/constant.dart';
import '../../../data/dto/backtest/backtest_dto.dart';
import '../../../service_locator.dart';
import 'bloc/backtest_bloc.dart';
import 'bloc/form/backtest_form_bloc.dart';
import 'component/basic_settings_tab.dart';
import 'component/strategy_settings_tab.dart';

class BacktestPage extends StatelessWidget {
  const BacktestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BacktestBloc, BacktestState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocState.initial:
            return BlocProvider(
              create: (context) => locator<BacktestFormBloc>()..add(LoadFormData()),
              child: _buildSettingsForm(context),
            );
          case BlocState.loading:
            return const Center(child: CircularProgressIndicator());
          case BlocState.success:
            return _buildSuccessView(context, state);
          case BlocState.failure:
            return _buildErrorView(context, state);
        }
      },
    );
  }

  Widget _buildSettingsForm(BuildContext context) {
    return BlocBuilder<BacktestFormBloc, BacktestFormState>(
      builder: (context, formState) {
        if (formState.status == FormStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (formState.status == FormStatus.error) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${formState.errorMessage}'),
                  ElevatedButton(
                    onPressed: () => context.read<BacktestFormBloc>().add(LoadFormData()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final theme = Theme.of(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: theme.colorScheme.background,
                child: TabBar(
                  tabs: const [
                    Tab(text: 'Settings'),
                    Tab(text: 'Strategies'),
                  ],
                  labelColor: theme.colorScheme.onBackground,
                  unselectedLabelColor: theme.colorScheme.onBackground.withOpacity(0.5),
                  indicatorColor: theme.colorScheme.onBackground,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            body: const TabBarView(
              children: [
                BasicSettingsTab(),
                StrategySettingsTab(),
              ],
            ),
            bottomNavigationBar: const _BottomActionBar(),
          ),
        );
      },
    );
  }


  Widget _buildSuccessView(BuildContext context, BacktestState state) {
    final result = state.result!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Strategy: ${result.strategyName}'),
            Text('Sharpe Ratio: ${result.performance.sharpe.toStringAsFixed(2)}'),
            Text('CAGR: ${(result.performance.cagr * 100).toStringAsFixed(2)}%'),
            Text('Final USDT: ${result.performance.finalUsdt.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () => context.read<BacktestBloc>().add(ResetBacktest()),
              child: const Text('Run Another Backtest'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, BacktestState state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error?.message ?? "Unknown error"}'),
            ElevatedButton(
              onPressed: () => context.read<BacktestBloc>().add(ResetBacktest()),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BacktestFormBloc, BacktestFormState>(
      builder: (context, formState) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ElevatedButton(
            onPressed: formState.startDate != null &&
                formState.endDate != null &&
                formState.strategies.isNotEmpty
                ? () {
              final backtestDto = BacktestDto(
                symbol: formState.symbol,
                usdt: formState.usdt,
                interval: formState.interval,
                startDate: formState.startDate!,
                endDate: formState.endDate!,
                tc: formState.tc,
                leverage: formState.leverage,
                strategies: formState.strategies,
              );
              context.read<BacktestBloc>().add(RunBacktest(backtestDto));
            }
                : null,
            child: const Text('Run Backtest'),
          ),
        );
      },
    );
  }
}