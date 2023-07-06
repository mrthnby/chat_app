import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  String? email;
  String? userName;
  String? displayName;
  String? profilePic;
  String? rank;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({required this.userId, required this.email, this.userName});

  Map<String, dynamic> toMap() {
    return {
      "userID": userId,
      "email": email,
      "userName": userName ?? "",
      "displayName": displayName ?? "",
      "profilePic": profilePic ?? "",
      "rank": rank ?? "1",
      "createdAt": createdAt ?? "",
      "updatedAt": updatedAt ?? "",
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : userId = map["userID"],
        email = map["email"],
        userName = map["userName"],
        displayName = map["displayName"],
        profilePic = map["profilePic"],
        rank = map["rank"],
        createdAt = (map["createdAt"] as Timestamp).toDate(),
        updatedAt = (map["updatedAt"] as Timestamp).toDate();

  @override
  String toString() {
    return "User {userId: $userId, email: $email, userName: $userName, displayName: $displayName, profilePic: $profilePic, rank: $rank, createdAt: $createdAt, updatedAt: $updatedAt}";
  }
}
