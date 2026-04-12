import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moovie/routes/app_router.dart';
import 'package:moovie/routes/route_title_resolver.dart';
import 'package:user_activity/new_user_activity_router.dart';

const _animationDuration = Duration(milliseconds: 300);

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _appBarController = AppBarController();
  TabsRouter? _tabsRouter;
  RoutingController? _activeTabRouter;
  bool _resolveScheduled = false;

  static const _tabRouteNames = [
    HomeTab.name,
    SearchTab.name,
    SocialTab.name,
    ProfileTab.name,
  ];

  void _attachToTabsRouter(TabsRouter tabsRouter) {
    if (_tabsRouter == tabsRouter) return;
    _detachListeners();
    _tabsRouter = tabsRouter;
    tabsRouter.addListener(_scheduleResolve);
    tabsRouter.root.navigationHistory.addListener(_scheduleResolve);
    _syncActiveTabRouter();
  }

  void _detachListeners() {
    _activeTabRouter?.removeListener(_scheduleResolve);
    _tabsRouter?.root.navigationHistory.removeListener(_scheduleResolve);
    _tabsRouter?.removeListener(_scheduleResolve);
    _activeTabRouter = null;
  }

  void _scheduleResolve() {
    if (_resolveScheduled) return;
    _resolveScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resolveScheduled = false;
      if (!mounted) return;
      _syncActiveTabRouter();
    });
  }

  void _syncActiveTabRouter() {
    final tabsRouter = _tabsRouter;
    if (tabsRouter == null) return;

    final activeTabName = _tabRouteNames[tabsRouter.activeIndex];
    final newRouter =
    tabsRouter.innerRouterOf<StackRouter>(activeTabName);

    if (_activeTabRouter != newRouter) {
      _activeTabRouter?.removeListener(_scheduleResolve);
      _activeTabRouter = newRouter;
      _activeTabRouter?.addListener(_scheduleResolve);
    }
    _resolveTitle();
  }

  void _resolveTitle() {
    final tabsRouter = _tabsRouter;
    if (tabsRouter == null) {
      _appBarController.update(title: null);
      return;
    }
    final activeTabName = _tabRouteNames[tabsRouter.activeIndex];
    final innerRouter =
    tabsRouter.innerRouterOf<StackRouter>(activeTabName);
    if (innerRouter == null) {
      _appBarController.update(title: null);
      return;
    }
    final topRoute = innerRouter.topRoute;
    final title = resolveRouteTitle(topRoute);
    _appBarController.update(title: title);
  }

  @override
  void dispose() {
    _detachListeners();
    _appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AutoTabsRouter(
      routes: const [HomeTab(), SearchTab(), SocialTab(), ProfileTab()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _attachToTabsRouter(tabsRouter);
        });

        final activeIndex = tabsRouter.activeIndex;
        final isHomeTab = activeIndex == 0;
        final tabTitles = [
          l10n?.appTitle ?? '',
          l10n?.search ?? '',
          l10n?.socialTab ?? '',
          l10n?.profile ?? '',
        ];
        final brightness = Theme.of(context).brightness;

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
                      final titleOverride = _appBarController.currentTitle;
                      final hasOverride = titleOverride != null;
                      final hideAppBar =
                          (activeIndex == 1 || activeIndex == 2) &&
                              !hasOverride;

                      return MoovieAnimatedAppBar(
                        title: titleOverride ?? tabTitles[activeIndex],
                        visible: !hideAppBar,
                        centerTitle: !hasOverride && isHomeTab,
                        leading: hasOverride
                            ? IconButton(
                                icon: const Icon(Icons.arrow_back),
                                tooltip: MaterialLocalizations.of(context)
                                    .backButtonTooltip,
                                onPressed: () {
                                  final tabsRouter = _tabsRouter;
                                  if (tabsRouter == null) return;
                                  final activeTabName =
                                      _tabRouteNames[tabsRouter.activeIndex];
                                  tabsRouter
                                      .innerRouterOf<StackRouter>(
                                          activeTabName)
                                      ?.maybePop();
                                },
                              )
                            : null,
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
            bottomNavigationBar: MoovieBottomNavigationBar(
              currentIndex: activeIndex,
              onTap: tabsRouter.setActiveIndex,
              centerItem: MoovieBottomNavigationBarItem(
                icon: Icons.add,
                label: l10n?.newUserActivityTab ?? '',
              ),
              onCenterTap: () => context.router.root
                  .push(const NewUserActivityRoute()),
              items: [
                MoovieBottomNavigationBarItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: l10n?.home ?? '',
                ),
                MoovieBottomNavigationBarItem(
                  icon: Icons.search,
                  label: l10n?.search ?? '',
                ),
                MoovieBottomNavigationBarItem(
                  icon: Icons.directions_run_outlined,
                  activeIcon: Icons.directions_run,
                  label: l10n?.socialTab ?? '',
                ),
                MoovieBottomNavigationBarItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: l10n?.profile ?? '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
