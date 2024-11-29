class MessagesResponse {
  String? message;
  List<Messages>? messages;

  MessagesResponse({this.message, this.messages});

  MessagesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? sId;
  String? message;
  String? senderId;
  String? receiverId;
  String? timestamp;
  int? iV;

  Messages(
      {this.sId,
      this.message,
      this.senderId,
      this.receiverId,
      this.timestamp,
      this.iV});

  Messages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    message = json['message'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    timestamp = json['timestamp'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['message'] = message;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['timestamp'] = timestamp;
    data['__v'] = iV;
    return data;
  }
}
