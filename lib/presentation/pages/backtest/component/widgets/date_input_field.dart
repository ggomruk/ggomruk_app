import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final DateTime? value;
  final String hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime)? onChanged;

  const DateInputField({
    Key? key,
    this.value,
    required this.hintText,
    this.firstDate,
    this.lastDate,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final now = DateTime.now();
        final date = await showDatePicker(
          context: context,
          initialDate: value ?? now,
          firstDate: firstDate ?? now.subtract(const Duration(days: 365)),
          lastDate: lastDate ?? now,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  surface: Theme.of(context).colorScheme.surface,
                  onSurface: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null && onChanged != null) {
          onChanged!(date);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value?.toString().split(' ')[0] ?? hintText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: value != null
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}