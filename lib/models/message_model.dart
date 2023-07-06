import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String from;
  final String to;
  final String content;
  final bool isFromMe;
  final Timestamp? date;

  MessageModel({
    required this.from,
    required this.to,
    required this.content,
    required this.isFromMe,
    this.date,
  });

  MessageModel.fromMap(Map<String, dynamic> data)
      : this(
          from: data["from"],
          to: data["to"],
          content: data["content"],
          isFromMe: data["isFromMe"],
          date: data["date"],
        );

  Map<String, dynamic> toMap() {
    return {
      "from": from,
      "to": to,
      "content": content,
      "isFromMe": isFromMe,
      "date": date ?? FieldValue.serverTimestamp(),
    };
  }
}
