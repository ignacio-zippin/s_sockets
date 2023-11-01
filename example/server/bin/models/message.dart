import 'dart:convert';

class Message {
  final String? message;

  Message({
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      "message": message,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map["message"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
