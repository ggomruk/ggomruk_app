import 'package:flutter/material.dart';

class IntervalDropdown extends StatelessWidget {
  final String value;
  final void Function(String?)? onChanged;

  const IntervalDropdown({
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const intervals = {
      '1m': '1 minute',
      '5m': '5 minute',
      '15m': '15 minute',
      '30m': '30 minute',
      '1h': '1 hour',
      '1d': '1 day',
    };

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: InputBorder.none,
          ),
          items: intervals.entries.map((entry) => DropdownMenuItem(
            value: entry.key,
            child: Text(entry.value),
          )).toList(),
          onChanged: onChanged,
          dropdownColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          icon: Icon(
            Icons.expand_more,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
