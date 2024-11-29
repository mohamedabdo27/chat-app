import 'package:chat_app/core/widgets/user_image.dart';
import 'package:chat_app/features/home/data/models/users_data/users.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.user});
  final Users user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserImage(imageUrl: user.imageUrl!),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "online",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff00A32B),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
