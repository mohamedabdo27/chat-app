import 'package:chat_app/core/utils/functions/format_time_date.dart';
import 'package:chat_app/core/widgets/user_image.dart';
import 'package:chat_app/features/chat/presentation/views/chat_view.dart';
import 'package:chat_app/features/home/data/models/users_data/users.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({super.key, required this.user});
  final Users user;
  @override
  Widget build(BuildContext context) {
    String message;
    String formatedTime = "";

    if (user.usersWithLastMsg != null) {
      formatedTime = formatDateTime(user.usersWithLastMsg!.timestamp!);

      if (user.id == user.usersWithLastMsg!.receiverId) {
        message = "You: ${user.usersWithLastMsg!.message}";
      } else {
        message = user.usersWithLastMsg!.message!;
      }
    } else {
      message = user.defaultMsg!;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatView(
              user: user,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserImage(imageUrl: user.imageUrl!),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          user.name!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        formatedTime,
                        style: const TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: SizedBox(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        message,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
