import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UserRequest {
  final String? name;
  final String email;
  final String password;
  final String? confirmPassword;
  final String? imageUrl;
  final File? imageFile;

  UserRequest({
    this.imageUrl,
    this.name,
    required this.email,
    required this.password,
    this.confirmPassword,
    required this.imageFile,
  });
  Future<FormData> toFormData() async {
    imageFile!.path.split('.').last.toLowerCase();
    MediaType contentType;
    if (imageFile!.path.split('.').last.toLowerCase() == "jpeg" ||
        imageFile!.path.split('.').last.toLowerCase() == "jpg") {
      contentType = MediaType("image", "jpeg");
    } else if (imageFile!.path.split('.').last.toLowerCase() == "png") {
      contentType = MediaType("image", "png");
    } else {
      throw UnsupportedError("can.t upload this image");
    }

    return FormData.fromMap(
      {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "image": await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
          contentType: contentType,
        ),
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "imageUrl":
          "https://i.pinimg.com/564x/49/97/ca/4997ca17bc81c58d21fcd13c5a4d88a8.jpg",
    };
  }
}
