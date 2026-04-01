import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moovie/routes/app_router.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeTab(),
        SearchTab(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: SafeArea(child: child),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          ),
        );
      },
    );
  }
}