import 'package:flutter/material.dart';

class MuuvieKeepAliveTab extends StatefulWidget {
  final Widget child;

  const MuuvieKeepAliveTab({super.key, required this.child});

  @override
  State<MuuvieKeepAliveTab> createState() => _MuuvieKeepAliveTabState();
}

class _MuuvieKeepAliveTabState extends State<MuuvieKeepAliveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
