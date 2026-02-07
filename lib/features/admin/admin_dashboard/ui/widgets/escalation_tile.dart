import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart'; // Ensure you have gap package or use SizedBox

class EscalationTile extends StatelessWidget {
  const EscalationTile({
    required this.caseId,
    required this.incidentType, // New Parameter
    required this.reason,
    required this.severity,
    super.key,
  });

  final String caseId;
  final String incidentType;
  final String reason;
  final String severity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCritical = severity == "CRITICAL";

    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(kDefaultRadius),
        border: Border.all(
          color: isCritical ? colorScheme.error : colorScheme.outlineVariant,
          width: isCritical ? 1.5 : 1, // Make border slightly thicker if critical
        ),
      ),
      child: Column(
        children: [
          // 1. TOP HEADER ROW (Case ID + Severity Badge)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                caseId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              // Severity Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCritical ? colorScheme.error : Colors.orange,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  severity,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12), // Or kGap12 if you have it defined

          // 2. MAIN CONTENT ROW (Icon + Type/Reason + Button)
          Row(
            children: [
              // Leading Icon Box
              Container(
                padding: const EdgeInsets.all(kSmallPadding),
                decoration: BoxDecoration(
                  color: isCritical
                      ? colorScheme.errorContainer
                      : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                ),
                child: Icon(
                  isCritical ? Icons.warning_rounded : Icons.info_outline_rounded,
                  color: isCritical ? colorScheme.error : Colors.orange.shade800,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 12), // kGap12

              // Incident Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      incidentType, // e.g., "Physical Bullying"
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      reason, // e.g., "Unresolved for 48h"
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Button (Only if Critical)
              if (isCritical)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 36),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Investigate",
                    style: TextStyle(
                      color: colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}