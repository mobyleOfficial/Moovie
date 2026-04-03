import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:public_profile/public_profile_bloc.dart';
import 'package:public_profile/public_profile_screen.dart';

@RoutePage()
class PublicProfilePage extends StatefulWidget {
  final String userId;

  const PublicProfilePage({super.key, required this.userId});

  @override
  State<PublicProfilePage> createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  late final PublicProfileCubit _cubit = PublicProfileCubit();
  AppBarController? _appBarController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _appBarController = AppBarControllerScope.find(context);
      _tabIndex = TabIndexScope.find(context) ?? 0;
      _appBarController?.setTitle(
        tabIndex: _tabIndex,
        title: widget.userId,
        onBack: () => context.router.maybePop(),
      );
    });
  }

  @override
  void dispose() {
    final controller = _appBarController;
    final tabIndex = _tabIndex;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller?.setTitle(tabIndex: tabIndex, title: null),
    );
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      PublicProfileScreen(cubit: _cubit, userId: widget.userId);
}
