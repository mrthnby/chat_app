import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String owner;
  final String interlocutor;
  final String lastMessage;
  final bool seen;
  final Timestamp? generateDate;
  Timestamp? seenDate;
  String timeDiff = "";

  ChatModel({
    required this.owner,
    required this.interlocutor,
    required this.lastMessage,
    required this.seen,
    this.generateDate,
    this.seenDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "owner": owner,
      "interlocutor": interlocutor,
      "lastMessage": lastMessage,
      "seen": seen,
      "generateDate": generateDate ?? FieldValue.serverTimestamp(),
      "seenDate": seenDate ?? Timestamp(0, 0),
    };
  }

  ChatModel.fromMap(Map<String, dynamic> data)
      : this(
          owner: data["owner"],
          interlocutor: data["interlocutor"],
          lastMessage: data["lastMessage"],
          seen: data["seen"],
          generateDate: data["generateDate"],
          seenDate: data["seenDate"],
        );
}
