import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/constant.dart';
import '../../../data/dto/backtest/backtest_dto.dart';
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

          final backtestDto = BacktestDto(
            symbol: "BTCUSDT",
            usdt: 10000,
            interval: "1m",
            startDate: DateTime.parse("2024-01-15T02:00:00"),
            endDate: DateTime.parse("2024-07-01T02:00:00"),
            tc: -0.00085,
            leverage: 3,
            strategies: {
              "RSI": {
                "periods": 14,
                "rsi_upper": 70,
                "rsi_lower": 30
              },
              "SMA": {
                "sma_s": 5,
                "sma_m": 100,
                "sma_l": 180
              },
              "RV": {
                "return_thresh_low": -0.01,
                "return_thresh_high": 0.01,
                "volume_thresh_low": -0.5,
                "volume_thresh_high": 0.5
              }
            },
          );

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