import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';

class SelectCounselorListTile extends StatelessWidget {
  final UserModel counselor;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectCounselorListTile({
    super.key,
    required this.counselor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          // width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(Icons.person, color: colorScheme.primary),
        ),
        title: Text(
          counselor.name, 
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
        ),
      ),
    );
  }
}
