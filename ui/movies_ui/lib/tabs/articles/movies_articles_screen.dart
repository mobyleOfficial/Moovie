import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:news/news.dart';
import 'package:movies_ui/tabs/articles/articles_cubit.dart';

class MoviesArticlesScreen extends StatelessWidget {
  final ArticlesCubit cubit;

  const MoviesArticlesScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedListView<int, Article>(
        state: pagingState,
        fetchNextPage: fetchNextPage,
        padding: const EdgeInsets.symmetric(vertical: 8),
        builderDelegate: PagedChildBuilderDelegate<Article>(
          itemBuilder: (context, article, index) => _ArticleTile(
            title: article.title,
            source: article.source,
            date: article.publishedAt,
            imageUrl: article.imageUrl,
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          firstPageErrorIndicatorBuilder: (_) => MoovieEmptyState(
            title: l10n?.emptyStateErrorTitle ?? '',
            message: l10n?.emptyStateErrorMessage ?? '',
            action: fetchNextPage,
            actionLabel: l10n?.emptyStateRetry ?? '',
          ),
          noItemsFoundIndicatorBuilder: (_) => MoovieEmptyState(
            title: l10n?.emptyStateNoItemsTitle ?? '',
            message: l10n?.emptyStateNoItemsMessage ?? '',
          ),
        ),
      ),
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final String title;
  final String source;
  final String date;
  final String? imageUrl;

  const _ArticleTile({
    required this.title,
    required this.source,
    required this.date,
    this.imageUrl,
  });

  String get _formattedDate {
    final parsed = DateTime.tryParse(date);
    if (parsed == null) return date;
    return DateFormat.yMMMd(Intl.getCurrentLocale()).format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '$title, $source, $_formattedDate',
      button: true,
      child: InkWell(
        onTap: () {},
        child: ExcludeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 64,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(6),
                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$source · $_formattedDate',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
