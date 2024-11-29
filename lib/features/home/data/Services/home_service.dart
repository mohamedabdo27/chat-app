import 'package:chat_app/core/utils/constants.dart';
import 'package:dio/dio.dart';

class HomeService {
  final Dio dio;

  HomeService({required this.dio});

  Future<Response> getUserData({required String token}) async {
    return await dio.get(
      "${Constants.kBaseUrl}chat/urContact",
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
