import 'package:flutter/material.dart';

class MoovieFilterChipBar extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const MoovieFilterChipBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text(labels[index]),
                selected: selectedIndex == index,
                onSelected: (_) => onSelected(index),
                selectedColor: colorScheme.secondaryContainer,
                checkmarkColor: colorScheme.onSecondaryContainer,
                labelStyle: TextStyle(
                  color: selectedIndex == index
                      ? colorScheme.onSecondaryContainer
                      : colorScheme.onSurfaceVariant,
                  fontWeight: selectedIndex == index
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
                showCheckmark: false,
              ),
            ),
        ],
      ),
    );
  }
}
