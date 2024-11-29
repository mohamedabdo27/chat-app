import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    required this.imageUrl,
    this.raduis = 24,
  });

  final String imageUrl;
  final double raduis;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: const Duration(seconds: 1),
      imageUrl: '${Constants.kBaseUrl}$imageUrl',
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: raduis,
        backgroundImage: imageProvider,
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: raduis,
        backgroundImage: const NetworkImage(
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
        ),
      ),
    );
  }
}
