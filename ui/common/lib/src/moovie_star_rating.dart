import 'package:flutter/material.dart';

class MoovieStarRating extends StatelessWidget {
  final double rating;
  final ValueChanged<double>? onRatingChanged;
  final double starSize;
  final Color? activeColor;
  final Color? inactiveColor;

  static const int _starCount = 5;

  const MoovieStarRating({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.starSize = 32,
    this.activeColor,
    this.inactiveColor,
  });

  double _ratingFromPosition(double localX) {
    final totalWidth = starSize * _starCount;
    final clamped = localX.clamp(0.0, totalWidth);
    final raw = clamped / starSize;
    return (raw * 2).ceilToDouble() / 2;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filledColor = activeColor ?? colorScheme.onTertiaryContainer;
    final emptyColor = inactiveColor ?? colorScheme.outlineVariant;
    final isInteractive = onRatingChanged != null;

    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_starCount, (index) {
        final isFilled = index < rating.floor();
        final isHalf = !isFilled && index < rating;

        return Icon(
          isHalf
              ? Icons.star_half
              : (isFilled ? Icons.star : Icons.star_border),
          size: starSize,
          color: (isFilled || isHalf) ? filledColor : emptyColor,
        );
      }),
    );

    if (!isInteractive) {
      return Semantics(
        label: '$rating out of $_starCount stars',
        child: ExcludeSemantics(child: stars),
      );
    }

    return Semantics(
      label: '$rating out of $_starCount stars',
      slider: true,
      value: '$rating',
      child: ExcludeSemantics(
        child: GestureDetector(
          onTapUp: (details) =>
              onRatingChanged!(_ratingFromPosition(details.localPosition.dx)),
          onHorizontalDragUpdate: (details) =>
              onRatingChanged!(_ratingFromPosition(details.localPosition.dx)),
          child: stars,
        ),
      ),
    );
  }
}
