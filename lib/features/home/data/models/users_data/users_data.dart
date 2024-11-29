import 'users.dart';

class UsersData {
  List<Users>? users;
  String? message;

  UsersData({this.users, this.message});

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
        users: (json['users'] as List<dynamic>?)
            ?.map((e) => Users.fromJson(e as Map<String, dynamic>))
            .toList(),
        message: json['message'] as String?,
      );
}
