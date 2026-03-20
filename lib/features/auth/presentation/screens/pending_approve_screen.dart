import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:apu_assignment/features/onboarding/ui/widgets/dynamic_svg.dart';
import 'package:apu_assignment/features/report/data/report_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String subtitle;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class PendingApproveScreen extends ConsumerWidget {
  const PendingApproveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userModelProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(kOnboardContentPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(100),
                DynamicSvg(
                  path: "assets/images/counselor_pending.svg",
                  replaceColorHex: '#92E3A9',
                ),
                Text(
                  "Pending Approval",
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Please wait until admin approves the account status of a counselor account.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Text(
          "Swipe down to Refresh",
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
