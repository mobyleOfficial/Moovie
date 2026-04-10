import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/watch_list/watch_list_screen.dart';

@RoutePage()
class WatchListPage extends StatefulWidget {
  final String userId;
  final String? userName;

  const WatchListPage({
    super.key,
    required this.userId,
    this.userName,
  });

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  late final GetUserWatchList _getUserWatchList =
      GetIt.I<GetUserWatchList>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final watchListLabel = l10n?.profileWatchlistSection ?? 'Watchlist';
    final title = widget.userName != null
        ? '${widget.userName} — $watchListLabel'
        : watchListLabel;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: WatchListScreen(
        getUserWatchList: _getUserWatchList,
        userId: widget.userId,
      ),
    );
  }
}
