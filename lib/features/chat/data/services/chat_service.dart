import 'package:chat_app/core/utils/constants.dart';
import 'package:dio/dio.dart';

class ChatService {
  final Dio dio;

  ChatService({required this.dio});

  Future<Response> getMessages({
    required String reseiverId,
    required String token,
  }) async {
    return await dio.get(
      "${Constants.kBaseUrl}chat/renderChat/$reseiverId",
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<Response> sendMessage({
    required String message,
    required String reseverId,
    required String token,
  }) async {
    return await dio.post(
      "${Constants.kBaseUrl}chat/send",
      data: {
        "msg": message,
        "receiver_id": reseverId,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
