import 'package:chat_app/features/auth/data/models/user_response/response_user.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class PickProfileImageSuccessState extends AuthState {}

class PickProfileImageFailuretate extends AuthState {
  final String error;

  PickProfileImageFailuretate({required this.error});
}

class SignUpSuccessState extends AuthState {
  final String token;
  final String userId;
  final UserResponse userModel;
  SignUpSuccessState({
    required this.userModel,
    required this.token,
    required this.userId,
  });
}

class SignUpLoadingState extends AuthState {}

class SignUpFailuretate extends AuthState {
  final String error;

  SignUpFailuretate({required this.error});
}

class LoginSuccessState extends AuthState {
  final UserResponse userModel;
  final String token;
  final String userId;

  LoginSuccessState({
    required this.userModel,
    required this.token,
    required this.userId,
  });
}

class LoginLoadingState extends AuthState {}

class LoginFailuretate extends AuthState {
  final String error;

  LoginFailuretate({required this.error});
}
