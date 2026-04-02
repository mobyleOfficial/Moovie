import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovie/routes/app_router.dart';
import 'package:new_user_activity/new_user_activity_router.dart';

const _animationDuration = Duration(milliseconds: 300);

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AutoTabsRouter(
      routes: const [HomeTab(), SearchTab(), SocialTab(), ProfileTab()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final isHomeTab = tabsRouter.activeIndex == 0;
        final isSearchTab = tabsRouter.activeIndex == 1;
        final tabTitles = [l10n.appTitle, l10n.search, l10n.socialTab, l10n.profile];
        final colorScheme = Theme.of(context).colorScheme;
        final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
        final addButtonIcon = Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.add, color: colorScheme.onSecondary),
        );
        return Scaffold(
          appBar: isSearchTab
              ? null
              : AppBar(
                  flexibleSpace: SafeArea(
                    child: AnimatedAlign(
                      duration: _animationDuration,
                      curve: Curves.easeInOut,
                      alignment: isHomeTab ? Alignment.center : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AnimatedSwitcher(
                          duration: _animationDuration,
                          transitionBuilder: (child, animation) {
                            final slideAnimation =
                                Tween<Offset>(
                                  begin: const Offset(0, 0.3),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                  ),
                                );
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: slideAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            tabTitles[tabsRouter.activeIndex],
                            key: ValueKey(tabsRouter.activeIndex),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          body: SafeArea(child: child),
          bottomNavigationBar: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              isIOS
                  ? CupertinoTabBar(
                      currentIndex: tabsRouter.activeIndex >= 2
                          ? tabsRouter.activeIndex + 1
                          : tabsRouter.activeIndex,
                      onTap: (index) {
                        if (index == 2) {
                          context.router.root.push(const NewUserActivityRoute());
                          return;
                        }
                        tabsRouter.setActiveIndex(index > 2 ? index - 1 : index);
                      },
                      activeColor: colorScheme.secondary,
                      items: [
                        BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), activeIcon: const Icon(Icons.home), label: l10n.home),
                        BottomNavigationBarItem(icon: const Icon(Icons.search), label: l10n.search),
                        BottomNavigationBarItem(icon: addButtonIcon, label: l10n.newUserActivityTab),
                        BottomNavigationBarItem(icon: const Icon(Icons.directions_run_outlined), activeIcon: const Icon(Icons.directions_run), label: l10n.socialTab),
                        BottomNavigationBarItem(icon: const Icon(Icons.person_outline), activeIcon: const Icon(Icons.person), label: l10n.profile),
                      ],
                    )
                  : NavigationBar(
                      selectedIndex: tabsRouter.activeIndex >= 2
                          ? tabsRouter.activeIndex + 1
                          : tabsRouter.activeIndex,
                      onDestinationSelected: (index) {
                        if (index == 2) {
                          context.router.root.push(const NewUserActivityRoute());
                          return;
                        }
                        tabsRouter.setActiveIndex(index > 2 ? index - 1 : index);
                      },
                      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                      destinations: [
                        NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: l10n.home),
                        NavigationDestination(icon: const Icon(Icons.search), label: l10n.search),
                        NavigationDestination(icon: addButtonIcon, label: l10n.newUserActivityTab),
                        NavigationDestination(icon: const Icon(Icons.directions_run_outlined), selectedIcon: const Icon(Icons.directions_run), label: l10n.socialTab),
                        NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: l10n.profile),
                      ],
                    ),
              Positioned(
                top: 8,
                child: FloatingActionButton(
                  onPressed: () => context.router.root.push(const NewUserActivityRoute()),
                  backgroundColor: colorScheme.secondary,
                  foregroundColor: colorScheme.onSecondary,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
