import 'package:flutter/material.dart';

class PostType extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  const PostType({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // List
    final List<Map<String, dynamic>> types = [
      {'label': 'Articles'},
      {'label': 'Events'},
      {'label': 'News'},
      {'label': 'Videos'},
    ];

    return PopupMenuButton<String>(
      initialValue: selectedType,
      onSelected: onTypeChanged,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedType,
              style: TextStyle(
                color: colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) => types.map((type) {
        return PopupMenuItem<String>(
          value: type['label'],
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(type['label'] as String),
            ],
          ),
        );
      }).toList(),
    );
  }
}