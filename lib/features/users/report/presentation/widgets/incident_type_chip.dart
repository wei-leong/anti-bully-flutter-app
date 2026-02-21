import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class IncidentTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const IncidentTypeChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color? finalBackgroundColor = isSelected
        ? colorScheme.surfaceContainerHighest
        : Colors.transparent;

    Color finalForegroundColor = isSelected
        ? colorScheme.onSurface
        : colorScheme.outlineVariant;

    double finalWidth = isSelected ? 1.5 : 1.0;

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultRadius),
          color: finalBackgroundColor,
          border: Border.all(width: finalWidth, color: finalForegroundColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: finalForegroundColor),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: finalForegroundColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
