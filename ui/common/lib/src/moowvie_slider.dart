import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_helper.dart';

class MoowvieSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;

  const MoowvieSlider({
    super.key,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoSlider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
      );
    }

    return Slider(
      value: value,
      min: min,
      max: max,
      onChanged: onChanged,
    );
  }
}
