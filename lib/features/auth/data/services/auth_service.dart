import 'dart:io';

import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/utils/api.dart';
import 'package:chat_app/features/auth/data/models/user_response/response_user.dart';
import 'package:chat_app/features/auth/data/models/user_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthService {
  AuthService(
    this.api,
  );

  final Api api;
  Future<Either<Failure, UserResponse>> signup({
    required File imageFile,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    UserRequest userRequest = UserRequest(
      confirmPassword: confirmPassword,
      imageFile: imageFile,
      name: name,
      password: password,
      email: email,
    );
    FormData userForm = await userRequest.toFormData();
    try {
      final data = await api.post(
        endPoint: 'auth/signup',
        body: userForm,
        contentType: 'multipart/form-data',
      );
      UserResponse userResponse = UserResponse.fromJson(data);
      // token = userResponse.token;

      return Right(userResponse);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(dioExcepition: e));
      } else {
        return left(ServerFailure(error: "Opps There was an error"));
      }
    }
  }

  Future<Either<Failure, UserResponse>> login({
    required String password,
    required String email,
  }) async {
    try {
      final data = await api.post(
        endPoint: "auth/login",
        body: {
          "email": email,
          "password": password,
        },
      );
      UserResponse userResponse = UserResponse.fromJson(data);

      return Right(userResponse);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(dioExcepition: e));
      } else {
        return left(ServerFailure(error: "Opps There was an error"));
      }
    }
  }
}
