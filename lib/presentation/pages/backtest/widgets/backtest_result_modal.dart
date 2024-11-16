import 'package:flutter/material.dart';
import '../../../../domain/model/backtest/backtest_model.dart';

class BacktestResultModal extends StatelessWidget {
  final BacktestModel result;
  final VoidCallback onClose;

  const BacktestResultModal({
    Key? key,
    required this.result,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 600,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24,
                      vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Backtest Results',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onClose,
                      ),
                    ],
                  ),
                ),

                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Strategy: ${result.strategyName}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildSection(
                          'Performance Metrics',
                          [
                            _buildMetricRow('Sharpe Ratio', result.performance.sharpe.toStringAsFixed(2)),
                            _buildMetricRow('CAGR', '${(result.performance.cagr * 100).toStringAsFixed(2)}%'),
                            _buildMetricRow('Annual Mean', '${(result.performance.annMean * 100).toStringAsFixed(2)}%'),
                            _buildMetricRow('Annual Standard Deviation', '${(result.performance.annStd * 100).toStringAsFixed(2)}'),
                            _buildMetricRow('Total Trades', result.performance.trades.toString()),
                          ],
                        ),
                        const SizedBox(height: 16),

                        _buildSection(
                          'Financial Results',
                          [
                            _buildMetricRow('Initial USDT', result.performance.initialUsdt.toStringAsFixed(2)),
                            _buildMetricRow('Final USDT', result.performance.finalUsdt.toStringAsFixed(2)),
                            _buildMetricRow('Strategy Return', '${(result.performance.cstrategy * 100).toStringAsFixed(2)}%'),
                            _buildMetricRow('Buy & Hold Return', '${(result.performance.bAndH * 100).toStringAsFixed(2)}%'),
                          ],
                        ),

                        if (result.leveragePerformance.leverageApplied > 1) ...[
                          const SizedBox(height: 16),
                          _buildSection(
                            'Leverage Performance',
                            [
                              _buildMetricRow('Leverage Applied', '${result.leveragePerformance.leverageApplied}x'),
                              _buildMetricRow('Leveraged CAGR', '${(result.leveragePerformance.cagr * 100).toStringAsFixed(2)}%'),
                              _buildMetricRow('Leveraged Sharpe', result.leveragePerformance.sharpe.toStringAsFixed(2)),
                              _buildMetricRow('Final USDT (Leveraged)', result.leveragePerformance.finalUsdtLevered.toStringAsFixed(2)),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24,
                      vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Save Result'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.play_arrow, size: 18),
                              Text('Apply Strategy'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  Widget _buildSection(String title, List<Widget> metrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...metrics,
      ],
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}