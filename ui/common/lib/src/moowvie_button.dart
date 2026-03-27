import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_helper.dart';

class MoowvieButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;

  const MoowvieButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoButton.filled(
        onPressed: onPressed,
        child: child,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: color != null
          ? ElevatedButton.styleFrom(backgroundColor: color)
          : null,
      child: child,
    );
  }
}

class MoowvieTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const MoowvieTextButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        child: child,
      );
    }

    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
