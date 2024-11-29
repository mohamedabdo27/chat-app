import 'dart:io';
import 'package:chat_app/features/auth/data/services/auth_service.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_state.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authService) : super(InitialAuthState());
  final AuthService authService;
  File? profileImage;

  final picker = ImagePicker();

  pickProfileImage() async {
    var pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100, // <- Reduce Image quality
      maxHeight: 500, // <- reduce the image size
      maxWidth: 500,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      emit(
        PickProfileImageFailuretate(error: "picked profile image error"),
      );
      debugPrint("picked profile image error");
    }
  }

  signup({
    required String password,
    required String email,
    required String name,
    required String confirmPassword,
  }) async {
    emit(SignUpLoadingState());

    final result = await authService.signup(
      name: name,
      confirmPassword: confirmPassword,
      password: password,
      email: email,
      imageFile: profileImage!,
    );
    result.fold((failure) {
      emit(SignUpFailuretate(error: failure.error));
    }, (userModel) {
      emit(SignUpSuccessState(
        token: userModel.token!,
        userId: userModel.user!.sId!,
        userModel: userModel,
      ));
      // token = userResponse.token;
      // userId = userResponse.user!.sId;
      userResponse = userModel;
      // userId = userResponse.user!.sId!;
      // token = userResponse.token!;
    });
  }

  login({
    required String password,
    required String email,
  }) async {
    emit(LoginLoadingState());
    final result = await authService.login(
      password: password,
      email: email,
    );
    result.fold((failure) {
      emit(LoginFailuretate(error: failure.error));
    }, (userModel) {
      // token = data["token"];
      // userId = data["userId"];
      // token = userResponse.token;
      // userId = userResponse.user!.sId;
      userResponse = userModel;
      emit(LoginSuccessState(
        userModel: userModel,
        token: userModel.token!,
        userId: userModel.user!.sId!,
      ));
    });
  }
}
