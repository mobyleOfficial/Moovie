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

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            for (var index = 0; index < labels.length; index++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilterChip(
                        label: Text(labels[index]),
                        selected: selectedIndex == index,
                        onSelected: (_) => onSelected(index),
                        backgroundColor: Colors.transparent,
                        selectedColor: Colors.transparent,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                        elevation: 0,
                        pressElevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        labelStyle: TextStyle(
                          color: selectedIndex == index
                              ? colorScheme.onSecondaryContainer
                              : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        showCheckmark: false,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: selectedIndex == index ? 2 : 0,
                        decoration: BoxDecoration(
                          color: colorScheme.onSecondaryContainer,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
