import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_domain/models/article.dart';
import 'package:news_ui/article_detail/article_detail_bloc.dart';
import 'package:news_ui/article_detail/article_detail_state.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleDetailCubit cubit;

  const ArticleDetailScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ArticleDetailCubit, ArticleDetailState>(
        builder: (context, state) => switch (state) {
          ArticleDetailLoading() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          ArticleDetailError(:final message) => Scaffold(
              body: MoovieEmptyState(
                title: l10n?.emptyStateErrorTitle ?? '',
                message: message,
                action: cubit.reload,
                actionLabel: l10n?.emptyStateRetry ?? '',
              ),
            ),
          ArticleDetailSuccess(:final article) => Scaffold(
              body: _ArticleDetailBody(article: article),
            ),
        },
      ),
    );
  }
}

class _ArticleDetailBody extends StatelessWidget {
  final Article article;

  const _ArticleDetailBody({required this.article});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _HeroAppBar(article: article),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ArticleInfoSection(article: article),
              _ArticleContentSection(content: article.content),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroAppBar extends StatelessWidget {
  final Article article;

  const _HeroAppBar({required this.article});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return SliverAppBar(
      expandedHeight: article.imageUrl != null ? 260 : 0,
      pinned: true,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      actions: [
        Tooltip(
          message: l10n?.articleDetailShare ?? 'Share article',
          child: IconButton(
            onPressed: () => _shareArticle(article),
            icon: const Icon(Icons.share_rounded),
          ),
        ),
      ],
      flexibleSpace: article.imageUrl != null
          ? FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: article.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    errorWidget: (_, _, _) => Container(
                      color: colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Future<void> _shareArticle(Article article) async {
    final payload =
        '${article.title}\n\n${article.summary}\n\n${article.sourceUrl}';
    await SharePlus.instance.share(ShareParams(text: payload));
  }
}

class _ArticleInfoSection extends StatelessWidget {
  final Article article;

  const _ArticleInfoSection({required this.article});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.source_rounded,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                article.source,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _Dot(color: colorScheme.onSurfaceVariant),
              Expanded(
                child: Text(
                  article.publishedAt,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            article.summary,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleContentSection extends StatelessWidget {
  final String content;

  const _ArticleContentSection({required this.content});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Text(
        content,
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
          height: 1.7,
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;

  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      );
}
