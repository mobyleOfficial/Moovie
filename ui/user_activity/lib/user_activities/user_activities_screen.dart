import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:user_activity/user_activities/user_activities_bloc.dart';
import 'package:user_activity/user_activities/user_activities_state.dart';
import 'package:user_activities_domain/models/user_activity.dart';
import 'package:user_activities_domain/usecases/get_user_activities.dart';

class UserActivitiesScreen extends StatefulWidget {
  final String userId;

  const UserActivitiesScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserActivitiesScreen> createState() => _UserActivitiesScreenState();
}

class _UserActivitiesScreenState extends State<UserActivitiesScreen> {
  late final UserActivitiesCubit _cubit = UserActivitiesCubit(
    getUserActivities: GetIt.I<GetUserActivities>(),
    userId: widget.userId,
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<UserActivitiesCubit, UserActivitiesState>(
          builder: (context, state) => switch (state) {
            UserActivitiesLoading() =>
              const Center(child: CircularProgressIndicator()),
            UserActivitiesError(:final message) =>
              Center(child: Text(message)),
            UserActivitiesSuccess(:final activities) =>
              _UserActivitiesList(activities: activities),
          },
        ),
      );
}

class _UserActivitiesList extends StatelessWidget {
  final List<UserActivity> activities;

  const _UserActivitiesList({required this.activities});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    if (activities.isEmpty) {
      return Center(
        child: Text(
          l10n?.noResults ?? '',
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: activities.length,
      separatorBuilder: (_, __) => Divider(
        indent: 56,
        height: 1,
        color: colorScheme.outlineVariant,
      ),
      itemBuilder: (context, index) =>
          _UserActivityTile(activity: activities[index]),
    );
  }
}

class _UserActivityTile extends StatelessWidget {
  final UserActivity activity;

  const _UserActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '${activity.action} ${activity.movie}, ${activity.time}',
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _activityIcon(activity.action),
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(text: '${activity.action} '),
                          TextSpan(
                            text: activity.movie,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                activity.time,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _activityIcon(String action) => switch (action) {
        'Watched' => Icons.visibility,
        'Reviewed' => Icons.rate_review,
        'Added to watchlist' => Icons.bookmark_add,
        'Liked review of' => Icons.favorite,
        _ => Icons.movie,
      };
}
