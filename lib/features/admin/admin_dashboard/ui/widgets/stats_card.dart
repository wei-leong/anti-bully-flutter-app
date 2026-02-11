import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(kDefaultRadius),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     color: color.withAlpha(30),
          //     borderRadius: BorderRadius.circular(kDefaultRadius),
          //   ),
          //   child: Icon(icon, color: color, size: 32),
          // ),
          kGap8,
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
