// ignore_for_file: constant_identifier_names

import 'dart:io';

import '../locator.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../services/base_services/auth_base.dart';
import '../services/firebase_auth_services.dart';
import '../services/firebase_storage_services.dart';
import '../services/firestore_db_services.dart';



enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  final AppMode _appMode = AppMode.RELEASE;
  final FirebaseAuthServices _firebaseAuthServices =
      locator<FirebaseAuthServices>();
  final FirestoreDbServices db = locator<FirestoreDbServices>();
  final FirebaseStorageServices storage = locator<FirebaseStorageServices>();

  @override
  Future<UserModel?> currentUser() async {
    if (_appMode == AppMode.RELEASE) {
      UserModel? user = await _firebaseAuthServices.currentUser();
      return await db.readUser(user!.userId);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    return _appMode == AppMode.RELEASE
        ? await _firebaseAuthServices.signInAnonymously()
        : null;
  }

  @override
  Future<bool> signOut() async {
    return _appMode == AppMode.RELEASE
        ? await _firebaseAuthServices.signOut()
        : false;
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    if (_appMode == AppMode.RELEASE) {
      final UserModel? user = await _firebaseAuthServices.signInWithGoogle();
      await db.saveUser(user!);
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String email, String password) async {
    if (_appMode == AppMode.RELEASE) {
      UserModel? user =
          await _firebaseAuthServices.signInWithEmail(email, password);
      return await db.readUser(user!.userId);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signUpWithEmail(
      String email, String password, String? userName) async {
    if (_appMode == AppMode.RELEASE) {
      final UserModel? user = await _firebaseAuthServices.signUpWithEmail(
          email, password, userName);
      await db.saveUser(user!);
      return await db.readUser(user.userId);
    } else {
      return null;
    }
  }

  Future<bool> updateUserName(String newUserName, String userId) async {
    if (_appMode == AppMode.RELEASE) {
      await db.updateUser(newUserName, userId);
      return true;
    }
    return false;
  }

  Future<String> updateProfilePhoto(
    String userId,
    String fileType,
    File file,
  ) async {
    if (_appMode == AppMode.RELEASE) {
      String fileUrl = await storage.upload(userId, fileType, file);
      await db.updateProfilePhoto(userId, fileUrl);
      return fileUrl;
    }
    return "";
  }

  Future<List<UserModel>> getAllUsers() async {
    if (_appMode == AppMode.RELEASE) {
      return await db.getAllUsers();
    }
    return [];
  }

  Stream<List<MessageModel>> getMessages({
    required String currentUser,
    required String interlocutor,
  }) {
    if (_appMode == AppMode.RELEASE) {
      return db.getMessages(
        currentUser,
        interlocutor,
      );
    }
    return const Stream.empty();
  }

  Future<void> saveMessage(MessageModel message) async {
    if (_appMode == AppMode.RELEASE) {
      await db.saveMessage(message);
    }
  }

  Future<List<ChatModel>> getConversations(String userId) async {
    return await db.getConversations(userId);
  }

  late UserModel user;
  Future<void> readUser(String userId) async {
    user = await db.readUser(userId);
  }

  UserModel getUser(String userId) {
    readUser(userId);
    return user;
  }

  Future<DateTime> getCurrentTime(String userId) async {
    return await db.getCurrentTime(userId);
  }
}
