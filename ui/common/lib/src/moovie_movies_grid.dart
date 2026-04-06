import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const int moovieGridCrossAxisCount = 3;
const double moovieGridChildAspectRatio = 2 / 3;
const double moovieGridSpacing = 8;
const double moovieGridPadding = 16;

const SliverGridDelegateWithFixedCrossAxisCount moovieGridDelegate =
    SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: moovieGridCrossAxisCount,
  childAspectRatio: moovieGridChildAspectRatio,
  crossAxisSpacing: moovieGridSpacing,
  mainAxisSpacing: moovieGridSpacing,
);

class MoovieMoviePosterCard extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;

  static const double _borderRadius = 10;

  const MoovieMoviePosterCard({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: InkWell(
          onTap: onTap,
          child: imageUrl != null
              ? Ink.image(
                  image: CachedNetworkImageProvider(imageUrl!),
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Icon(Icons.movie, size: 36),
                ),
        ),
      ),
    );
}