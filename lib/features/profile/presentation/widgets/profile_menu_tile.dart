import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive; // For "Log Out" (Other Dangerous Action)
  final Widget? trailing; // Custom Trailing Widget (Switch, CheckBox)

  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final contentColor = isDestructive
        ? colorScheme.error
        : colorScheme.onSurface;
    final iconBgColor = isDestructive
        ? colorScheme.errorContainer
        : colorScheme.primaryContainer;
    final iconColor = isDestructive ? colorScheme.error : colorScheme.onPrimary;

    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // 1. Icon Box
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const Gap(16),

              // 2. Title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: contentColor,
                  ),
                ),
              ),

              // 3. Trailing (Arrow or Switch)
              trailing ??
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
