import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/profile/presentation/viewmodels/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSelectorCard extends ConsumerWidget {
  const ThemeSelectorCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentTheme = ref.watch(themeViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.color_lens,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          title: Text("Theme"),
          subtitle: Text("Configure Theme"),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: SegmentedButton(
            segments: <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                icon: Icon(Icons.light_mode_rounded),
                label: Text("Light"),
                value: ThemeMode.light,
              ),
              ButtonSegment<ThemeMode>(
                icon: Icon(Icons.dark_mode_rounded),
                label: Text("Dark"),
                value: ThemeMode.dark,
              ),
              ButtonSegment<ThemeMode>(
                icon: Icon(Icons.auto_mode_rounded),
                label: Text("System"),
                value: ThemeMode.system,
              ),
            ],
            style: ButtonStyle(
              side: WidgetStatePropertyAll(
                BorderSide(color: colorScheme.outline, width: 1),
              ),
            ),
            selected: {currentTheme},
            onSelectionChanged: (Set<ThemeMode> newSelection) async {
              ThemeMode selectedTheme = newSelection.first;
              ref.read(themeViewModelProvider.notifier).changeTheme(selectedTheme);
            },
          ),
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}
