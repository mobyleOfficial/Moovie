import 'package:flutter/widgets.dart';

class AppBarController extends ChangeNotifier {
  String? _currentTitle;

  String? get currentTitle => _currentTitle;

  void update({required String? title}) {
    if (_currentTitle == title) return;
    _currentTitle = title;
    notifyListeners();
  }
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
