import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:public_profile/public_profile_router.dart';
import 'package:social/tabs/activities/activities_bloc.dart';
import 'package:user_activities/user_activities.dart';

class ActivitiesScreen extends StatelessWidget {
  final ActivitiesCubit cubit;

  const ActivitiesScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedListView<int, UserActivity>(
        state: pagingState,
        fetchNextPage: fetchNextPage,
        padding: const EdgeInsets.symmetric(vertical: 8),
        builderDelegate: PagedChildBuilderDelegate<UserActivity>(
          itemBuilder: (context, activity, index) => Column(
            children: [
              if (index > 0)
                Divider(
                  height: 1,
                  indent: 72,
                  color: colorScheme.outlineVariant,
                ),
              _ActivityTile(activity: activity),
            ],
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

class _ActivityTile extends StatelessWidget {
  final UserActivity activity;

  const _ActivityTile({required this.activity});

  String get _initials {
    final parts = activity.userName.split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}';
    }
    return activity.userName.isNotEmpty ? activity.userName[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '${activity.userName} ${activity.action} ${activity.movie}, ${activity.time}',
      button: true,
      child: InkWell(
        onTap: () => context.router.push(
          PublicProfileRoute(userId: activity.userName),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              ExcludeSemantics(
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Text(
                    _initials,
                    style: TextStyle(
                      color: colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: activity.userName,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: ' ${activity.action.toLowerCase()} ',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          TextSpan(
                            text: activity.movie,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activity.time,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              ExcludeSemantics(
                child: Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
