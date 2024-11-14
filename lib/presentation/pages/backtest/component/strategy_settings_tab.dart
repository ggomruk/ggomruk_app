import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/form/backtest_form_bloc.dart';

class StrategySettingsTab extends StatelessWidget {
  const StrategySettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BacktestFormBloc, BacktestFormState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildStrategyList(context, state),
            const SizedBox(height: 16),
            _buildAddStrategyButton(context, state),
          ],
        );
      },
    );
  }

  Widget _buildStrategyList(BuildContext context, BacktestFormState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Strategy',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...state.strategies.entries.map(
              (entry) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context.read<BacktestFormBloc>().add(
                            RemoveStrategy(entry.key),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._buildStrategyParameters(
                    context,
                    state,
                    entry.key,
                    entry.value,
                    state.availableStrategies[entry.key]?['parameters'] as Map<String, dynamic>?,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                param.key,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
              flex: 3,
              child: TextFormField(
                initialValue: param.value.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
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
    return ElevatedButton(
      onPressed: state.availableStrategies.isEmpty
          ? null
          : () {
        final formBloc = context.read<BacktestFormBloc>();
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Add Strategy'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: state.availableStrategies.entries
                    .where((strategy) => !state.strategies.containsKey(strategy.key))
                    .map((strategy) => ListTile(
                  title: Text(strategy.key),
                  onTap: () {
                    formBloc.add(AddStrategy(
                      strategy.key,
                      Map<String, dynamic>.from(strategy.value['parameters'] as Map<String, dynamic>),
                    ));
                    Navigator.pop(dialogContext);
                  },
                ))
                    .toList(),
              ),
            ),
          ),
        );
      },
      child: const Text('Add Strategy'),
    );
  }
}