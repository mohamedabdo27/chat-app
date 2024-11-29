import 'package:chat_app/features/auth/data/models/user_response/user.dart';
import 'package:hive/hive.dart';
part 'response_user.g.dart';

@HiveType(typeId: 1)
class UserResponse {
  @HiveField(0)
  User? user;
  @HiveField(1)
  String? token;
  @HiveField(2)
  String? message;

  UserResponse({
    this.user,
    this.token,
    this.message,
  });

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    message = json['message'];
  }
}
