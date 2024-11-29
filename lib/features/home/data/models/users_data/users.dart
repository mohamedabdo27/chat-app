import 'users_with_last_msg.dart';

class Users {
  String? id;
  String? name;
  String? imageUrl;
  int? v;
  UsersWithLastMsg? usersWithLastMsg;
  String? defaultMsg;

  Users({
    this.id,
    this.name,
    this.imageUrl,
    this.v,
    this.usersWithLastMsg,
    this.defaultMsg,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        imageUrl: json['imageUrl'] as String?,
        v: json['__v'] as int?,
        usersWithLastMsg: json['usersWithLastMsg'] == null
            ? null
            : UsersWithLastMsg.fromJson(
                json['usersWithLastMsg'] as Map<String, dynamic>),
        // usersWithLastMsg: UsersWithLastMsg.fromJson(json['usersWithLastMsg'] ),
        // (json['usersWithLastMsg'] as List<dynamic>?)?.map((e) => UsersWithLastMsg.fromJson(e as Map<String, dynamic>))
        //     .toList(),
        defaultMsg: json['defaultMsg'] as String?,
      );
}
