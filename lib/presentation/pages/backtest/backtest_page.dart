import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/constant.dart';
import '../../../data/dto/backtest/backtest_dto.dart';
import '../../../data/mock/backtest_mock_data.dart';
import 'bloc/backtest_bloc.dart';

class BacktestPage extends StatelessWidget {
  const BacktestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BacktestBloc, BacktestState>(
        builder: (context, state) {
          switch (state.status) {
            case BlocState.initial:
              return _buildInitialForm(context);
            case BlocState.loading:
              return const Center(child: CircularProgressIndicator());
            case BlocState.success:
              return _buildSuccessView(context, state);
            case BlocState.failure:
              return _buildErrorView(context, state);
          }
        },
      ),
    );
  }


  Widget _buildInitialForm(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final backtestDto = BacktestMockData.mockRequest;
          context.read<BacktestBloc>().add(RunBacktest(backtestDto));
        },
        child: const Text('Run Backtest'),
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context, BacktestState state) {
    final result = state.result!;
    return Center(
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
    );
  }

  Widget _buildErrorView(BuildContext context, BacktestState state) {
    return Center(
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
    );
  }
}