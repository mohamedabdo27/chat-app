import 'package:chat_app/features/chat/data/services/chat_service.dart';
import 'package:chat_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/custom_app_bar.dart';
import 'package:chat_app/features/home/data/models/users_data/users.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.user});
  final Users user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(ChatService(dio: Dio()))
        ..getMessages(reseiverId: user.id!)
        ..updateChatMessages(
          freindId: user.id!,
        ),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F8F8),
        appBar: AppBar(
          title: CustomAppBar(
            user: user,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
        ),
        body: ChatViewBody(user: user),
      ),
    );
  }
}
