class UsersWithLastMsg {
  String? message;
  String? senderId;
  String? receiverId;
  String? timestamp;
  int? v;

  UsersWithLastMsg({
    this.message,
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.v,
  });

  factory UsersWithLastMsg.fromJson(Map<String, dynamic> json) {
    return UsersWithLastMsg(
      message: json['message'] as String?,
      senderId: json['sender_id'] as String?,
      receiverId: json['receiver_id'] as String?,
      timestamp:
          json['timestamp'] == null ? null : (json['timestamp'] as String),
      v: json['__v'] as int?,
    );
  }
}
