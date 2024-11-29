import 'package:chat_app/core/widgets/user_image.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    required this.width,
    this.onTap,
  });

  final double width;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
      insetPadding: EdgeInsets.only(
        left: width * .55,
        right: 16,
        top: 70,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserImage(imageUrl: userResponse!.user!.imageUrl!),
          const SizedBox(
            height: 9,
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            userResponse!.user!.name!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: onTap,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
