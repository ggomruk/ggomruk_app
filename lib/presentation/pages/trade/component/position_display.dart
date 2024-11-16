import 'package:flutter/material.dart';

class PositionDisplay extends StatelessWidget {
  final double position;

  const PositionDisplay({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Position',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _getPositionText(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: _getPositionColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPositionText() {
    if (position > 0) return 'LONG';
    if (position < 0) return 'SHORT';
    return 'NEUTRAL';
  }

  Color _getPositionColor() {
    if (position > 0) return Colors.green;
    if (position < 0) return Colors.red;
    return Colors.grey;
  }
}