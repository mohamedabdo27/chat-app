import 'dart:io';

import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickProfileImage extends StatelessWidget {
  const PickProfileImage({
    super.key,
    required this.image,
  });
  final File? image;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundImage: image != null ? FileImage(image!) : null,
            radius: 42,
          ),
          Positioned(
              top: 50,
              child: InkWell(
                onTap: () {
                  BlocProvider.of<AuthCubit>(context).pickProfileImage();
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Constants.kPrimaryColor,
                  child: Icon(Icons.camera_alt_outlined),
                ),
              )),
        ],
      ),
    );
  }
}
