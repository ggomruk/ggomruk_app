import 'package:flutter/material.dart';

class InputSection extends StatelessWidget {
  final String title;
  final Widget child;
  final String? description;
  final bool useBackground;

  const InputSection({
    Key? key,
    required this.title,
    required this.child,
    this.description,
    this.useBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: useBackground ? Theme.of(context).colorScheme.surface : null,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}