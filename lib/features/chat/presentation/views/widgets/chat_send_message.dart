import 'package:chat_app/core/widgets/custom_bottun.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:chat_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSendMessage extends StatefulWidget {
  const ChatSendMessage({
    super.key,
    required this.receiverId,
  });
  final String receiverId;
  @override
  State<ChatSendMessage> createState() => _ChatSendMessageState();
}

class _ChatSendMessageState extends State<ChatSendMessage> {
  final controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 112,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomTextField(
                  hintTextColor: const Color(0xff838383),
                  fillColor: const Color(0xffE8E8E8),
                  controller: controller,
                  hintText: "Enter Message",
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                        message: controller.text,
                        reseverId: widget.receiverId,
                      );
                      controller.clear();
                    }
                  },
                  text: "Send",
                  height: 56,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
