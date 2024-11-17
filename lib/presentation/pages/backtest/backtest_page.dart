import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/constant.dart';
import '../../../data/dto/backtest/backtest_dto.dart';
import '../../../service_locator.dart';
import 'bloc/backtest_bloc.dart';
import 'bloc/form/backtest_form_bloc.dart';
import 'component/basic_settings_tab.dart';
import 'component/strategy_settings_tab.dart';
import 'widgets/backtest_result_modal.dart';
import 'widgets/error_result_modal.dart';

class BacktestPage extends StatelessWidget {
  const BacktestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BacktestBloc, BacktestState>(
      listener: (context, state) {
        // 성공 상태일 때 결과 모달 표시
        if (state.status == BlocState.success && state.showResult) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => BacktestResultModal(
              result: state.result!,
              onClose: () {
                context.read<BacktestBloc>().add(const HideBacktestResult());
                Navigator.pop(context);
              },
            ),
          );
        }

        // 실패 상태일 때 에러 모달 표시
        if (state.status == BlocState.failure) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ErrorResultModal(
              message: state.error?.message ?? "Unknown error",
              onClose: () {
                context.read<BacktestBloc>().add(ResetBacktest());
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == BlocState.initial || !state.isFormLoaded) {
          return BlocProvider(
            create: (context) => locator<BacktestFormBloc>()..add(LoadFormData()),
            child: _buildSettingsForm(context),
          );
        }

        if (state.status == BlocState.loading) {
          return Stack(
            children: [
              _buildSettingsForm(context),
              Container(
                // color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }

        // 성공/실패 상태에서도 기존 form 유지
        return _buildSettingsForm(context);
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