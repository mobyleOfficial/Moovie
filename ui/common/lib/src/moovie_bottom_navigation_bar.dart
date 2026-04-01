import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_helper.dart';

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
        items: items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon:
                    item.activeIcon != null ? Icon(item.activeIcon) : null,
                label: item.label,
              ),
            )
            .toList(),
      );
    }

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon:
                  item.activeIcon != null ? Icon(item.activeIcon) : null,
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
