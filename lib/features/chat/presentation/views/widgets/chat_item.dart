import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/core/utils/functions/format_time_date.dart';
import 'package:chat_app/features/chat/data/models/messages.dart';

import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({
    super.key,
    required this.messageModel,
    required this.receiverId,
    required this.index,
  });
  final String receiverId;
  final int index;
  final Messages messageModel;

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    bool isMe = false;
    if (widget.messageModel.receiverId == widget.receiverId) {
      isMe = true;
    }
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: isMe
            ? const EdgeInsets.only(left: 20)
            : const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isMe
                    ? Constants.kMyChatItemColor
                    : Constants.kFriendChatItemColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.messageModel.message!.length > 200
                          ? expanded
                              ? widget.messageModel.message!
                              : '${widget.messageModel.message!.substring(0, 199)}...'
                          : widget.messageModel.message!,
                      textAlign: isMe ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    if (widget.messageModel.message!.length > 200)
                      TextButton(
                        onPressed: () {
                          expanded = !expanded;
                          setState(() {});
                        },
                        child: expanded
                            ? const Text("see less")
                            : const Text("see more"),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(formatDateTime(widget.messageModel.timestamp!))
          ],
        ),
      ),
    );
  }
}
