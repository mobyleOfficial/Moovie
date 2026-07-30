import 'package:flutter/material.dart';

class MuuvieTabBar extends StatefulWidget {
  final List<String> tabs;
  final TabController? controller;
  final bool isScrollable;

  const MuuvieTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
  });

  @override
  State<MuuvieTabBar> createState() => _MuuvieTabBarState();
}

class _MuuvieTabBarState extends State<MuuvieTabBar> {
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateController();
  }

  @override
  void didUpdateWidget(MuuvieTabBar oldWidget) {
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

    return TabBar(
      controller: tabController,
      isScrollable: widget.isScrollable,
      tabAlignment: widget.isScrollable ? TabAlignment.start : null,
      labelColor: colorScheme.onSecondaryContainer,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      indicatorColor: colorScheme.onSecondaryContainer,
      dividerColor: colorScheme.outlineVariant,
      tabs: widget.tabs
          .map(
            (tabLabel) => Tab(
              child: Text(
                tabLabel,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
    );
  }
}
