import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
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
          bottomNavigationBar: MoovieBottomNavigationBar(
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
            items: [
              MoovieBottomNavigationBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: l10n.home,
              ),
              MoovieBottomNavigationBarItem(
                icon: Icons.search,
                label: l10n.search,
              ),
              MoovieBottomNavigationBarItem(
                icon: Icons.add,
                label: l10n.newUserActivityTab,
              ),
              MoovieBottomNavigationBarItem(
                icon: Icons.directions_run_outlined,
                activeIcon: Icons.directions_run,
                label: l10n.socialTab,
              ),
              MoovieBottomNavigationBarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: l10n.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
