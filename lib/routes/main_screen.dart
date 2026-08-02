import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:muuvie/routes/app_router.dart';
import 'package:muuvie/routes/main_bloc.dart';
import 'package:muuvie/routes/main_state.dart';
import 'package:muuvie/routes/route_title_resolver.dart';
import 'package:profile/profile.dart';
import 'package:reviews/review_creation/review_creation_router.dart';
import 'package:user_activity/new_user_activity/new_user_activity_router.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _appBarController = AppBarController();
  late final MainCubit _mainCubit = MainCubit(
    GetIt.I(),
    GetIt.I(),
    GetIt.I(),
  );
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
    _mainCubit.close();
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

                      return MuuvieAnimatedAppBar(
                        title: titleOverride ?? tabTitles[activeIndex],
                        visible: !hideAppBar,
                        centerTitle: !hasOverride && isHomeTab,
                        actions: _appBarController.currentActions,
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
                  BlocBuilder<MainCubit, MainState>(
                    bloc: _mainCubit,
                    buildWhen: (prev, curr) =>
                        prev is! MainSuccess ||
                        curr is! MainSuccess ||
                        prev.isScraping != curr.isScraping,
                    builder: (context, state) {
                      if (state is MainSuccess && state.isScraping) {
                        return _ScrapingBanner();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  BlocBuilder<MainCubit, MainState>(
                    bloc: _mainCubit,
                    builder: (context, mainState) =>
                        switch (mainState) {
                      MainSuccess(
                        :final hasSubmissions,
                        :final hasError,
                      ) =>
                        () {
                          if (!hasSubmissions) {
                            return const SizedBox.shrink();
                          }
                          final draft = hasError
                              ? mainState.firstError
                              : mainState.firstSubmitting;
                          if (draft == null) {
                            return const SizedBox.shrink();
                          }
                          return MuuvieSubmissionBanner(
                            reviewTitle: draft.reviewTitle.isNotEmpty
                                ? draft.reviewTitle
                                : draft.movieTitle,
                            isError: hasError,
                            onTap: hasError
                                ? () => context.router.root.push(
                                      ReviewCreationRoute(
                                        movieId: draft.movieId,
                                        movieTitle: draft.movieTitle,
                                        posterPath: draft.posterPath,
                                        initialDraft: draft,
                                      ),
                                    )
                                : null,
                            onDismiss: hasError
                                ? () => _mainCubit
                                    .dismissError(draft.movieId)
                                : null,
                          );
                        }(),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                  TabIndexScope(
                    tabIndex: activeIndex,
                    child: Expanded(
                      child: AppBarControllerScope(
                        controller: _appBarController,
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: MuuvieBottomNavigationBar(
              currentIndex: activeIndex,
              onTap: (index) async {
                if (index == 2 || index == 3) {
                  final allowed = await AuthGate.check(context);
                  if (!allowed) return;
                }
                tabsRouter.setActiveIndex(index);
              },
              centerItem: MuuvieBottomNavigationBarItem(
                icon: Icons.add,
                label: l10n?.newUserActivityTab ?? '',
              ),
              onCenterTap: () async {
                final allowed = await AuthGate.check(context);
                if (!allowed) return;
                if (context.mounted) {
                  context.router.root.push(const NewUserActivityRoute());
                }
              },
              items: [
                MuuvieBottomNavigationBarItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: l10n?.home ?? '',
                ),
                MuuvieBottomNavigationBarItem(
                  icon: Icons.search,
                  label: l10n?.search ?? '',
                ),
                MuuvieBottomNavigationBarItem(
                  icon: Icons.directions_run_outlined,
                  activeIcon: Icons.directions_run,
                  label: l10n?.socialTab ?? '',
                ),
                MuuvieBottomNavigationBarItem(
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

class _ScrapingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: colorScheme.primaryContainer,
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Importando dados...',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
