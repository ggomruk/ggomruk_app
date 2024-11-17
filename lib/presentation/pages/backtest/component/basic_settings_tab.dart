import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/number_formatter.dart';
import '../bloc/form/backtest_form_bloc.dart';
import 'widgets/input_section.dart';
import 'widgets/number_input_field.dart';
import 'widgets/date_input_field.dart';
import 'widgets/interval_dropdown.dart';

class BasicSettingsTab extends StatelessWidget {
  const BasicSettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BacktestFormBloc, BacktestFormState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputSection(
                title: 'Symbol Search',
                // description: '백테스트를 수행할 가상화폐를 선택',
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    value: state.symbol,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      border: InputBorder.none,
                    ),
                    items: state.availableSymbols.map((symbol) => DropdownMenuItem(
                      value: symbol,
                      child: Text(symbol),
                    )).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<BacktestFormBloc>().add(
                          UpdateBasicSettings(symbol: value),
                        );
                      }
                    },
                  ),
                ),
              ),

              InputSection(
                title: 'Investment Amount (USDT)',
                // description: '백테스트에 사용할 초기 투자금을 입력',
                child: NumberInputField(
                  initialValue: state.usdt.toString(),
                  hintText: '1,000 ~ 10,000,000',
                  allowDecimal: true,
                  onChanged: (value) {
                    final usdt = double.tryParse(value);
                    if (usdt != null && usdt >= 1000 && usdt <= 10000000) {
                      context.read<BacktestFormBloc>().add(
                        UpdateBasicSettings(usdt: usdt),
                      );
                    }
                  },
                ),
              ),

              InputSection(
                title: 'Testing Period',
                // description: '백테스트를 수행할 기간을 선택',
                useBackground: false,
                child: Row(
                  children: [
                    Expanded(
                      child: DateInputField(
                        value: state.startDate,
                        hintText: 'from',
                        lastDate: state.endDate ?? DateTime.now(),
                        onChanged: (date) {
                          context.read<BacktestFormBloc>().add(
                            UpdateBasicSettings(startDate: date),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
                      child: DateInputField(
                        value: state.endDate,
                        hintText: 'to',
                        firstDate: state.startDate,
                        onChanged: (date) {
                          context.read<BacktestFormBloc>().add(
                            UpdateBasicSettings(endDate: date),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              InputSection(
                title: 'Interval',
                // description: '백테스트의 시간 단위를 선택',
                child: IntervalDropdown(
                  value: state.interval,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<BacktestFormBloc>().add(
                        UpdateBasicSettings(interval: value),
                      );
                    }
                  },
                ),
              ),

              InputSection(
                title: 'Transaction Cost',
                // description: '거래당 적용될 수수료를 입력',
                child: NumberInputField(
                  initialValue: NumberFormatter.tcToPercentage(state.tc), // -0.00085 -> 0.085
                  hintText: '0.001 ~ 1.000 %',
                  suffix: const Text('%'),
                  allowDecimal: true,
                  onChanged: (value) {
                    final tc = NumberFormatter.percentageToTc(value); // 0.085 -> -0.00085
                    if (tc >= -0.01 && tc <= -0.00001) {
                      context.read<BacktestFormBloc>().add(
                        UpdateBasicSettings(tc: tc),
                      );
                    }
                  },
                ),
              ),

              InputSection(
                title: 'Leverage',
                // description: '적용할 레버리지 배수를 입력',
                child: NumberInputField(
                  initialValue: state.leverage.toString(),
                  hintText: '1 ~ 100',
                  allowDecimal: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final leverage = int.tryParse(value);
                    if (leverage != null && leverage >= 1 && leverage <= 100) {
                      context.read<BacktestFormBloc>().add(
                        UpdateBasicSettings(leverage: leverage),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}