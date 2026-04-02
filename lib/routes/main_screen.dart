import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:moovie/routes/app_router.dart';
import 'package:new_user_activity/new_user_activity_router.dart';
import 'package:profile_ui/profile_router.dart';

const _animationDuration = Duration(milliseconds: 300);

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AutoTabsRouter(
      routes: const [
        HomeTab(),
        SearchTab(),
        SocialTab(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final isHomeTab = tabsRouter.activeIndex == 0;
        final tabTitles = [l10n.appTitle, l10n.search, l10n.socialTab];
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: SafeArea(
              child: AnimatedAlign(
                duration: _animationDuration,
                curve: Curves.easeInOut,
                alignment:
                    isHomeTab ? Alignment.center : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AnimatedSwitcher(
                    duration: _animationDuration,
                    child: Text(
                      tabTitles[tabsRouter.activeIndex],
                      key: ValueKey(tabsRouter.activeIndex),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {
                  context.router.root.push(const ProfileRoute());
                },
              ),
            ],
          ),
          body: SafeArea(child: child),
          floatingActionButton: FloatingActionButton(
            backgroundColor: MoovieColors.secondary,
            foregroundColor: MoovieColors.onSecondaryContainer,
            onPressed: () {
              context.router.root.push(const NewUserActivityRoute());
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: MoovieBottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
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
                icon: Icons.directions_run_outlined,
                activeIcon: Icons.directions_run,
                label: l10n.socialTab,
              ),
            ],
          ),
        );
      },
    );
  }
}
