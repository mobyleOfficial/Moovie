import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_helper.dart';

class MoovieCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MoovieCloseButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final onTap = onPressed ?? () => Navigator.of(context).pop();
    final closeLabel = MaterialLocalizations.of(context).closeButtonTooltip;

    if (isIOS) {
      return Semantics(
        label: closeLabel,
        button: true,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: const Icon(CupertinoIcons.xmark, color: CupertinoColors.white),
        ),
      );
    }

    return IconButton(
      tooltip: closeLabel,
      icon: const Icon(Icons.close, color: Colors.white),
      onPressed: onTap,
    );
  }
}
