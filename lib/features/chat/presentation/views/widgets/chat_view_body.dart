import 'package:chat_app/features/chat/presentation/views/widgets/chat_list_view.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/chat_send_message.dart';
import 'package:chat_app/features/home/data/models/users_data/users.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key, required this.user});
  final Users user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ChatListView(receiverId: user.id!),
        ),
        ChatSendMessage(receiverId: user.id!),
      ],
    );
  }
}
