import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/trade_bloc.dart';
import 'component/position_display.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeBloc, TradeState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Mock Trading Controls
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mock Trading Settings',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        // Trading Controls
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: state.isTrading
                                    ? null
                                    : () => _startMockTrading(context),
                                child: const Text('Start Trading'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: state.isTrading
                                    ? () => context.read<TradeBloc>().add(StopTrade())
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Stop Trading'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Position Display
                if (state.trade != null) ...[
                  PositionDisplay(position: state.trade!.position),
                  const SizedBox(height: 16),
                  // Trading Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trading Info',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text('Symbol: ${state.trade!.params.symbol}'),
                          Text('Interval: ${state.trade!.params.interval}'),
                          Text('Active Strategies: ${state.trade!.params.strategies.keys.join(", ")}'),
                        ],
                      ),
                    ),
                  ),
                ],
                if (state.error != null)
                  Card(
                    color: Colors.red[100],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Error: ${state.error!.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startMockTrading(BuildContext context) {
    context.read<TradeBloc>().add(
      StartTrade(
        symbol: "ETHUSDT",
        interval: "15m",
        strategies: {
          "MACD": {
            "ema_s": 12,
            "ema_l": 26,
            "signal_mw": 9
          },
          "SO": {
            "periods": 14,
            "d_mw": 3
          }
        },
        uid: "mock_trade_${DateTime.now().millisecondsSinceEpoch}",
      ),
    );
  }
}