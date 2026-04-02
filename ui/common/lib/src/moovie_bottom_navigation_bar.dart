import 'package:common/src/theme/moovie_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:common/src/platform_helper.dart';

class MoovieBottomNavigationBarItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const MoovieBottomNavigationBarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class MoovieBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<MoovieBottomNavigationBarItem> items;

  const MoovieBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: onTap,
        activeColor: MoovieColors.secondary,
        items: items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon: Icon(item.activeIcon ?? item.icon),
                label: item.label,
              ),
            )
            .toList(),
      );
    }

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.activeIcon ?? item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
