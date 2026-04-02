import 'package:common/src/platform_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoovieTabBar extends StatefulWidget {
  final List<String> tabs;
  final TabController? controller;

  const MoovieTabBar({
    super.key,
    required this.tabs,
    this.controller,
  });

  @override
  State<MoovieTabBar> createState() => _MoovieTabBarState();
}

class _MoovieTabBarState extends State<MoovieTabBar> {
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateController();
  }

  @override
  void didUpdateWidget(MoovieTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _updateController();
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    super.dispose();
  }

  void _updateController() {
    final newController =
        widget.controller ?? DefaultTabController.maybeOf(context);
    if (_tabController != newController) {
      _tabController?.removeListener(_onTabChanged);
      _tabController = newController;
      _tabController?.addListener(_onTabChanged);
    }
  }

  void _onTabChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tabController = _tabController;

    if (tabController == null) return const SizedBox.shrink();

    if (isIOS) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CupertinoSlidingSegmentedControl<int>(
          groupValue: tabController.index,
          thumbColor: colorScheme.secondary,
          backgroundColor: colorScheme.surfaceContainerHighest,
          onValueChanged: (index) {
            if (index != null) tabController.animateTo(index);
          },
          children: {
            for (var tabIndex = 0; tabIndex < widget.tabs.length; tabIndex++)
              tabIndex: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.tabs[tabIndex],
                  style: TextStyle(
                    color: tabController.index == tabIndex
                        ? colorScheme.onSecondary
                        : colorScheme.onSurfaceVariant,
                    fontSize: 13,
                    fontWeight: tabController.index == tabIndex
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
          },
        ),
      );
    }

    return TabBar(
      controller: tabController,
      labelColor: colorScheme.onSecondaryContainer,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      indicatorColor: colorScheme.onSecondaryContainer,
      dividerColor: colorScheme.outlineVariant,
      tabs: widget.tabs.map((tabLabel) => Tab(text: tabLabel)).toList(),
    );
  }
}
