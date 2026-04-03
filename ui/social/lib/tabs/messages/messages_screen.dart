import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:public_profile/public_profile_router.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _mockConversations.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 72,
        color: colorScheme.outlineVariant,
      ),
      itemBuilder: (context, index) {
        final conversation = _mockConversations[index];
        return _ConversationTile(conversation: conversation);
      },
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final _Conversation conversation;

  const _ConversationTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '${conversation.senderName}, ${conversation.lastMessage}, ${conversation.time}',
      button: true,
      child: InkWell(
        onTap: () => context.router.root.push(
          PublicProfileRoute(userId: conversation.senderName),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: conversation.avatarColor,
                      child: Text(
                        conversation.initials,
                        style: TextStyle(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (conversation.isUnread)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(color: colorScheme.surface, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.senderName,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: conversation.isUnread ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          conversation.time,
                          style: textTheme.bodySmall?.copyWith(
                            color: conversation.isUnread
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onSurfaceVariant,
                            fontWeight: conversation.isUnread ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      conversation.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: conversation.isUnread
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                        fontWeight: conversation.isUnread ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Conversation {
  final String senderName;
  final String initials;
  final String lastMessage;
  final String time;
  final bool isUnread;
  final Color avatarColor;

  const _Conversation({
    required this.senderName,
    required this.initials,
    required this.lastMessage,
    required this.time,
    required this.isUnread,
    required this.avatarColor,
  });
}

const _mockConversations = [
  _Conversation(
    senderName: 'Alice Martins',
    initials: 'AM',
    lastMessage: 'Have you watched Oppenheimer yet? It\'s incredible!',
    time: '2m',
    isUnread: true,
    avatarColor: Color(0xFFFFD1DC),
  ),
  _Conversation(
    senderName: 'Bruno Carvalho',
    initials: 'BC',
    lastMessage: 'That ending was so unexpected 😱',
    time: '15m',
    isUnread: true,
    avatarColor: Color(0xFFF7E07E),
  ),
  _Conversation(
    senderName: 'Camila Torres',
    initials: 'CT',
    lastMessage: 'Let\'s do a movie night this weekend!',
    time: '1h',
    isUnread: false,
    avatarColor: Color(0xFFFFD1DC),
  ),
  _Conversation(
    senderName: 'Diego Ferreira',
    initials: 'DF',
    lastMessage: 'Agreed, Nolan is a genius',
    time: '3h',
    isUnread: false,
    avatarColor: Color(0xFFF7E07E),
  ),
  _Conversation(
    senderName: 'Elena Souza',
    initials: 'ES',
    lastMessage: 'Added it to my watchlist!',
    time: 'Yesterday',
    isUnread: false,
    avatarColor: Color(0xFFFFD1DC),
  ),
  _Conversation(
    senderName: 'Felipe Lima',
    initials: 'FL',
    lastMessage: 'What do you think about the new A24 film?',
    time: 'Mon',
    isUnread: false,
    avatarColor: Color(0xFFF7E07E),
  ),
];
