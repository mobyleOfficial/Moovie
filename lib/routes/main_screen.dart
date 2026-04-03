import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moovie/routes/app_router.dart';
import 'package:new_user_activity/new_user_activity_router.dart';

const _animationDuration = Duration(milliseconds: 300);

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _appBarController = AppBarController();

  @override
  void dispose() {
    _appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppBarControllerScope(
      notifier: _appBarController,
      child: AutoTabsRouter(
        routes: const [HomeTab(), SearchTab(), SocialTab(), ProfileTab()],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          final activeIndex = tabsRouter.activeIndex;
          final isHomeTab = activeIndex == 0;
          final tabTitles = [
            l10n.appTitle,
            l10n.search,
            l10n.socialTab,
            l10n.profile,
          ];
          final colorScheme = Theme.of(context).colorScheme;
          final brightness = Theme.of(context).brightness;
          final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
          final addButtonIcon = Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(Icons.add, color: colorScheme.onSecondary),
          );

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                    .copyWith(statusBarColor: Colors.transparent)
                : SystemUiOverlayStyle.dark
                    .copyWith(statusBarColor: Colors.transparent),
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    ListenableBuilder(
                      listenable: _appBarController,
                      builder: (context, _) {
                        final titleOverride =
                            _appBarController.titleForTab(activeIndex);
                        final hasOverride = titleOverride != null;

                        final hideAppBar =
                            (activeIndex == 1 || activeIndex == 2) &&
                                !hasOverride;

                        return ClipRect(
                          child: AnimatedAlign(
                            duration: _animationDuration,
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            heightFactor: hideAppBar ? 0.0 : 1.0,
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: _animationDuration,
                                    curve: Curves.easeInOut,
                                    width: hasOverride ? 48.0 : 16.0,
                                    child: hasOverride
                                        ? IconButton(
                                            icon: const Icon(
                                                Icons.arrow_back),
                                            tooltip:
                                                MaterialLocalizations.of(
                                                        context)
                                                    .backButtonTooltip,
                                            onPressed: () {
                                              final back = _appBarController
                                                  .backActionForTab(
                                                      activeIndex);
                                              _appBarController.setTitle(
                                                tabIndex: activeIndex,
                                                title: null,
                                              );
                                              back?.call();
                                            },
                                          )
                                        : null,
                                  ),
                                  Expanded(
                                    child: AnimatedAlign(
                                      duration: _animationDuration,
                                      curve: Curves.easeInOut,
                                      alignment:
                                          (!hasOverride && isHomeTab)
                                              ? Alignment.center
                                              : Alignment.centerLeft,
                                      child: AnimatedSwitcher(
                                        duration: _animationDuration,
                                        transitionBuilder:
                                            (child, animation) {
                                          final slide = Tween<Offset>(
                                            begin:
                                                const Offset(0, 0.3),
                                            end: Offset.zero,
                                          ).animate(CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOut,
                                          ));
                                          return FadeTransition(
                                            opacity: animation,
                                            child: SlideTransition(
                                              position: slide,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Text(
                                          titleOverride ??
                                              tabTitles[activeIndex],
                                          key: ValueKey<String>(
                                            titleOverride ??
                                                tabTitles[activeIndex],
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    TabIndexScope(
                      tabIndex: activeIndex,
                      child: Expanded(child: child),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  isIOS
                      ? CupertinoTabBar(
                          currentIndex: activeIndex >= 2
                              ? activeIndex + 1
                              : activeIndex,
                          onTap: (index) {
                            if (index == 2) {
                              context.router.root
                                  .push(const NewUserActivityRoute());
                              return;
                            }
                            tabsRouter.setActiveIndex(
                                index > 2 ? index - 1 : index);
                          },
                          activeColor: colorScheme.secondary,
                          items: [
                            BottomNavigationBarItem(
                                icon: const Icon(Icons.home_outlined),
                                activeIcon: const Icon(Icons.home),
                                label: l10n.home),
                            BottomNavigationBarItem(
                                icon: const Icon(Icons.search),
                                label: l10n.search),
                            BottomNavigationBarItem(
                                icon: addButtonIcon,
                                label: l10n.newUserActivityTab),
                            BottomNavigationBarItem(
                                icon: const Icon(
                                    Icons.directions_run_outlined),
                                activeIcon:
                                    const Icon(Icons.directions_run),
                                label: l10n.socialTab),
                            BottomNavigationBarItem(
                                icon: const Icon(Icons.person_outline),
                                activeIcon: const Icon(Icons.person),
                                label: l10n.profile),
                          ],
                        )
                      : NavigationBar(
                          selectedIndex: activeIndex >= 2
                              ? activeIndex + 1
                              : activeIndex,
                          onDestinationSelected: (index) {
                            if (index == 2) {
                              context.router.root
                                  .push(const NewUserActivityRoute());
                              return;
                            }
                            tabsRouter.setActiveIndex(
                                index > 2 ? index - 1 : index);
                          },
                          labelBehavior:
                              NavigationDestinationLabelBehavior
                                  .onlyShowSelected,
                          destinations: [
                            NavigationDestination(
                                icon: const Icon(Icons.home_outlined),
                                selectedIcon: const Icon(Icons.home),
                                label: l10n.home),
                            NavigationDestination(
                                icon: const Icon(Icons.search),
                                label: l10n.search),
                            NavigationDestination(
                                icon: addButtonIcon,
                                label: l10n.newUserActivityTab),
                            NavigationDestination(
                                icon: const Icon(
                                    Icons.directions_run_outlined),
                                selectedIcon:
                                    const Icon(Icons.directions_run),
                                label: l10n.socialTab),
                            NavigationDestination(
                                icon: const Icon(Icons.person_outline),
                                selectedIcon: const Icon(Icons.person),
                                label: l10n.profile),
                          ],
                        ),
                  Positioned(
                    top: 8,
                    child: FloatingActionButton(
                      onPressed: () => context.router.root
                          .push(const NewUserActivityRoute()),
                      tooltip: l10n.newUserActivityTab,
                      backgroundColor: colorScheme.secondary,
                      foregroundColor: colorScheme.onSecondary,
                      child: const Icon(Icons.add, semanticLabel: ''),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
