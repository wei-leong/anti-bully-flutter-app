import 'package:flutter/material.dart';

class IncidentListTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const IncidentListTile({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: colorScheme.primary),
      ),
      title: Text(
        title,
        style: textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant, // Greyish title
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        description,
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface, // Darker, prominent description
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
