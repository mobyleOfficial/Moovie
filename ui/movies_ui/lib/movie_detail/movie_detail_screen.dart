import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_ui/movie_detail/movie_detail_bloc.dart';
import 'package:movies_ui/movie_detail/movie_detail_state.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieDetailCubit cubit;

  const MovieDetailScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) => switch (state) {
          MovieDetailLoading() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          MovieDetailError(:final message) => Scaffold(
              body: Center(child: Text(message)),
            ),
          MovieDetailSuccess(:final detail) => Scaffold(
              appBar: AppBar(title: Text(detail.title)),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (detail.backdropPath.isNotEmpty)
                      Image.network(
                        'https://image.tmdb.org/t/p/w780${detail.backdropPath}',
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (detail.tagline.isNotEmpty)
                            Text(
                              detail.tagline,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          const SizedBox(height: 8),
                          Text(detail.overview),
                          const SizedBox(height: 16),
                          Text(l10n.movieRelease(detail.releaseDate)),
                          Text(l10n.movieRating(detail.voteAverage.toStringAsFixed(1))),
                          if (detail.runtime != null)
                            Text(l10n.movieRuntime(detail.runtime!)),
                          if (detail.genres.isNotEmpty)
                            Text(l10n.movieGenres(detail.genres.join(', '))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        },
      ),
    );
  }
}
