import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_ui/favorite_movies/favorite_movies_screen.dart';
import 'package:profile/profile.dart';

@RoutePage()
class FavoriteMoviesPage extends StatefulWidget {
  final String userId;
  final String? userName;

  const FavoriteMoviesPage({
    super.key,
    required this.userId,
    this.userName,
  });

  @override
  State<FavoriteMoviesPage> createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends State<FavoriteMoviesPage> {
  late final GetUserFavoriteMovies _getUserFavoriteMovies =
      GetIt.I<GetUserFavoriteMovies>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final favoriteMoviesLabel = l10n?.profileFavoriteMovies ?? 'Favorite Movies';
    final title = widget.userName != null
        ? '${widget.userName} — $favoriteMoviesLabel'
        : favoriteMoviesLabel;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FavoriteMoviesScreen(
        getUserFavoriteMovies: _getUserFavoriteMovies,
        userId: widget.userId,
      ),
    );
  }
}
