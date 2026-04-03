import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:public_profile/public_profile_router.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _mockFriends.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 72,
        color: colorScheme.outlineVariant,
      ),
      itemBuilder: (context, index) {
        final friend = _mockFriends[index];
        return _FriendTile(friend: friend);
      },
    );
  }
}

class _FriendTile extends StatelessWidget {
  final _Friend friend;

  const _FriendTile({required this.friend});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '${friend.name}, ${friend.moviesWatched} movies watched',
      button: true,
      child: ListTile(
        onTap: () => context.router.root.push(
          PublicProfileRoute(userId: friend.name),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: ExcludeSemantics(
          child: CircleAvatar(
            radius: 24,
            backgroundColor: friend.avatarColor,
            child: Text(
              friend.initials,
              style: TextStyle(
                color: colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text(
          friend.name,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${friend.moviesWatched} movies watched',
          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        trailing: _FollowButton(isFollowing: friend.isFollowing),
      ),
    );
  }
}

class _FollowButton extends StatefulWidget {
  final bool isFollowing;

  const _FollowButton({required this.isFollowing});

  @override
  State<_FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<_FollowButton> {
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isFollowing;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: _isFollowing ? 'Unfollow' : 'Follow',
      child: GestureDetector(
        onTap: () => setState(() => _isFollowing = !_isFollowing),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: _isFollowing ? colorScheme.surfaceContainerHighest : colorScheme.secondary,
            borderRadius: BorderRadius.circular(50),
            border: _isFollowing
                ? Border.all(color: colorScheme.outlineVariant)
                : null,
          ),
          child: Text(
            _isFollowing ? 'Following' : 'Follow',
            style: TextStyle(
              color: _isFollowing
                  ? colorScheme.onSurfaceVariant
                  : colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _Friend {
  final String name;
  final String initials;
  final int moviesWatched;
  final bool isFollowing;
  final Color avatarColor;

  const _Friend({
    required this.name,
    required this.initials,
    required this.moviesWatched,
    required this.isFollowing,
    required this.avatarColor,
  });
}

const _mockFriends = [
  _Friend(name: 'Alice Martins', initials: 'AM', moviesWatched: 312, isFollowing: true, avatarColor: Color(0xFFFFD1DC)),
  _Friend(name: 'Bruno Carvalho', initials: 'BC', moviesWatched: 187, isFollowing: false, avatarColor: Color(0xFFF7E07E)),
  _Friend(name: 'Camila Torres', initials: 'CT', moviesWatched: 540, isFollowing: true, avatarColor: Color(0xFFFFD1DC)),
  _Friend(name: 'Diego Ferreira', initials: 'DF', moviesWatched: 95, isFollowing: false, avatarColor: Color(0xFFF7E07E)),
  _Friend(name: 'Elena Souza', initials: 'ES', moviesWatched: 228, isFollowing: true, avatarColor: Color(0xFFFFD1DC)),
  _Friend(name: 'Felipe Lima', initials: 'FL', moviesWatched: 413, isFollowing: false, avatarColor: Color(0xFFF7E07E)),
  _Friend(name: 'Gabriela Nunes', initials: 'GN', moviesWatched: 76, isFollowing: true, avatarColor: Color(0xFFFFD1DC)),
  _Friend(name: 'Henrique Costa', initials: 'HC', moviesWatched: 601, isFollowing: false, avatarColor: Color(0xFFF7E07E)),
];
