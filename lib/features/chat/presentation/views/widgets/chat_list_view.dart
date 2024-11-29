import 'package:chat_app/core/utils/functions/snak_bar.dart';
import 'package:chat_app/features/chat/data/models/messages.dart';
import 'package:chat_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/view_models/chat_cubit/chat_state.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({
    super.key,
    required this.receiverId,
  });
  final String receiverId;

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  ScrollController controller = ScrollController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is GetMessagesFailureState) {
            showSnackBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          if (state is GetMessagesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMessagesFailureState) {
            return Center(
              child: Text(state.error),
            );
          }

          List<Messages> messages =
              BlocProvider.of<ChatCubit>(context).messages;
          if (messages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.jumpTo(0);
            });

            return ListView.separated(
              controller: controller,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 31,
                );
              },
              itemBuilder: (context, index) => ChatItem(
                index: index,
                messageModel: messages[index],
                receiverId: widget.receiverId,
              ),
              itemCount: messages.length,
            );
          } else {
            return const Center(
              child: Text("start conversation"),
            );
          }
        },
      ),
    );
  }
}
