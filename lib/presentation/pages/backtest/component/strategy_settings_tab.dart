import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/form/backtest_form_bloc.dart';
import 'widgets/collapsible_strategy_card.dart';

class StrategySettingsTab extends StatelessWidget {
  const StrategySettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BacktestFormBloc, BacktestFormState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildHeader(context, state),
            const SizedBox(height: 16),
            _buildStrategyList(context, state),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, BacktestFormState state) {
    final strategiesCount = state.strategies.length;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Strategy Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$strategiesCount ${strategiesCount == 1 ? 'strategy' : 'strategies'} selected',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const Spacer(),
        if (state.strategies.isNotEmpty)
          FilledButton.tonalIcon(
            onPressed: () => _showAddStrategyDialog(context, state),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add More'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
      ],
    );
  }

  Widget _buildStrategyList(BuildContext context, BacktestFormState state) {
    if (state.strategies.isEmpty) {
      return _buildEmptyState(context);
    }

    return Column(
      children: state.strategies.entries.map(
            (entry) => CollapsibleStrategyCard(
          strategyName: entry.key,
          parameters: entry.value,
          parameterInfo: state.availableStrategies[entry.key]?['parameters'] as Map<String, dynamic>?,
          onRemove: () {
            context.read<BacktestFormBloc>().add(
              RemoveStrategy(entry.key),
            );
          },
          onParameterChanged: (paramName, value) {
            final updatedParams = Map<String, dynamic>.from(entry.value);
            updatedParams[paramName] = value;
            context.read<BacktestFormBloc>().add(
              AddStrategy(entry.key, updatedParams),
            );
          },
        ),
      ).toList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_graph,
                size: 48,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ),
              const SizedBox(height: 16),
              Text(
                'No Strategies Added',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add a strategy to start backtesting',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => _showAddStrategyDialog(context, context.read<BacktestFormBloc>().state),
                icon: const Icon(Icons.add),
                label: const Text('Add Strategy'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStrategyParameters(
      BuildContext context,
      BacktestFormState state,
      String strategyName,
      Map<String, dynamic> currentParams,
      Map<String, dynamic>? parameterInfo,
      ) {
    if (parameterInfo == null) return [];

    return currentParams.entries.map((param) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                param.key,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextFormField(
                initialValue: param.value.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (value) {
                  final newValue = num.tryParse(value);
                  if (newValue != null) {
                    final updatedParams = Map<String, dynamic>.from(currentParams);
                    updatedParams[param.key] = newValue;
                    context.read<BacktestFormBloc>().add(
                      AddStrategy(strategyName, updatedParams),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildAddStrategyButton(BuildContext context, BacktestFormState state) {
    // 모든 상황에서 빈 위젯 반환 (빈 상태 UI의 버튼만 사용)
    return const SizedBox.shrink();
  }

  void _showAddStrategyDialog(BuildContext context, BacktestFormState state) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.auto_graph,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('Add Strategy'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: state.availableStrategies.entries
                .where((strategy) => !state.strategies.containsKey(strategy.key))
                .map((strategy) => ListTile(
              leading: const Icon(Icons.trending_up),
              title: Text(
                strategy.key,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                context.read<BacktestFormBloc>().add(AddStrategy(
                  strategy.key,
                  Map<String, dynamic>.from(strategy.value['parameters'] as Map<String, dynamic>),
                ));
                Navigator.pop(dialogContext);
              },
            ))
                .toList(),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}