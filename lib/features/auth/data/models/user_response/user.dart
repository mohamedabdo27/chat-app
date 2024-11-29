import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? imageUrl;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? password;
  @HiveField(4)
  String? sId;
  @HiveField(5)
  int? iV;

  User({
    this.name,
    this.imageUrl,
    this.email,
    this.password,
    this.sId,
    this.iV,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    email = json['email'];
    password = json['password'];
    sId = json['_id'];
    iV = json['__v'];
  }
}
