import 'package:flutter/widgets.dart';

class AppBarController extends ChangeNotifier {
  final Map<int, String> _overrides = {};
  final Map<int, VoidCallback> _backActions = {};

  String? titleForTab(int tabIndex) => _overrides[tabIndex];
  VoidCallback? backActionForTab(int tabIndex) => _backActions[tabIndex];

  void setTitle({
    required int tabIndex,
    required String? title,
    VoidCallback? onBack,
  }) {
    final current = _overrides[tabIndex];
    if (current == title) return;
    if (title == null) {
      _overrides.remove(tabIndex);
      _backActions.remove(tabIndex);
    } else {
      _overrides[tabIndex] = title;
      if (onBack != null) _backActions[tabIndex] = onBack;
    }
    notifyListeners();
  }
}

class AppBarControllerScope extends InheritedNotifier<AppBarController> {
  const AppBarControllerScope({
    super.key,
    required AppBarController super.notifier,
    required super.child,
  });

  static AppBarController? find(BuildContext context) =>
      context.findAncestorWidgetOfExactType<AppBarControllerScope>()?.notifier;
}

class TabIndexScope extends StatelessWidget {
  final int tabIndex;
  final Widget child;

  const TabIndexScope({
    super.key,
    required this.tabIndex,
    required this.child,
  });

  static int? find(BuildContext context) =>
      context.findAncestorWidgetOfExactType<TabIndexScope>()?.tabIndex;

  @override
  Widget build(BuildContext context) => child;
}
