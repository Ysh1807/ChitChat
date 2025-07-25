import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return Center(
              child: Text('No messages found.'),
            );
          }

          if (chatSnapshots.hasError) {
            return Center(
              child: Text('Something went wrong...'),
            );
          }

          final loadedMessages = chatSnapshots.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.only(
              bottom: 40,
              left: 13,
              right: 13,
            ),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) {
              final chatMessage = loadedMessages[index].data();
              final nextChatMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1].data()
                  : null;
              final currMessageUserId = chatMessage['userId'];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['userId'] : null;
              final nextUserIsSame = nextMessageUserId == currMessageUserId;
              Widget content;
              if (nextUserIsSame) {
                content = MessageBubble.next(
                    message: chatMessage['text'],
                    isMe: authenticatedUser.uid == currMessageUserId);
              } else {
                content = MessageBubble.first(
                    userImage: chatMessage['userImage'],
                    username: chatMessage['username'],
                    message: chatMessage['text'],
                    isMe: authenticatedUser.uid == currMessageUserId);
              }
              return GestureDetector(
                onLongPress: () async {
                  final confirm = await showDialog<bool>(
                    context: ctx,
                    builder: (ctx) => AlertDialog(
                      title: Text('Delete Message'),
                      content:
                          Text('Are you sure you want to delete this message?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: Text('Delete')),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await FirebaseFirestore.instance
                        .collection('chat')
                        .doc(loadedMessages[index]
                            .id) // msg.id is the Firestore document ID
                        .delete();
                  }
                },
                child: content,
              );
            },
          );
        });
  }
}
