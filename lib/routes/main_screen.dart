import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:moovie/routes/app_router.dart';
import 'package:new_user_activity/new_user_activity_router.dart';
import 'package:profile_ui/profile_router.dart';

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
        ActivitiesTab(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appTitle),
            centerTitle: true,
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
                label: l10n.activitiesTab,
              ),
            ],
          ),
        );
      },
    );
  }
}
