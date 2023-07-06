

import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

abstract class DBbase {
  Future<bool> saveUser(UserModel user);
  Future<UserModel> readUser(String userId);
  Future<bool> updateUser(String newUserName, String userId);
  Future<bool> updateProfilePhoto(String userId, String file);
  Future<List<UserModel>> getAllUsers();
  Stream<List<MessageModel>> getMessages(
      String currentUser, String interlocutor);
  Future<void> saveMessage(MessageModel message);
  Future<List<ChatModel>> getConversations(String userId);
}
