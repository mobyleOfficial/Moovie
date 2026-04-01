import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:moovie/routes/app_router.dart';
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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: l10n.search,
              ),
            ],
          ),
        );
      },
    );
  }
}
