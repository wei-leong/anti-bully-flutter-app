import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/profile/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSelectorCard extends ConsumerWidget {
  const ThemeSelectorCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentTheme = ref.watch(themeProvider);
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
              String saveTheme = "";
    
              switch (selectedTheme) {
                case ThemeMode.system:
                  saveTheme = "System";
                  break;
                case ThemeMode.light:
                  saveTheme = "Light";
                  break;
                case ThemeMode.dark:
                  saveTheme = "Dark";
                  break;
              }
    
              ref.read(themeProvider.notifier).changeTheme(selectedTheme);
            },
          ),
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}
