// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:io';


import 'package:flutter/cupertino.dart';

import '../locator.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../repository/user_repository.dart';
import '../services/base_services/auth_base.dart';

enum ViewState { IDLE, BUSY }

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.IDLE;
  final UserRepository _userRepository = locator<UserRepository>();
  UserModel? _user;
  String? emailErrorMessage;
  String? passwordErrorMessage;
  List<UserModel> allUsers = [];

  UserViewModel() {
    currentUser();
  }

  UserModel? get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      state = ViewState.BUSY;
      _user = await _userRepository.currentUser();
      return _user;
    } catch (e) {
      print("USER VIEW MODEL CURRENTUSER ERROR $e");
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try {
      state = ViewState.BUSY;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      print("USER VIEW MODEL ANONYMSIGNIN ERROR $e");
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.BUSY;
      bool result = await _userRepository.signOut();
      _user = null;
      return result;
    } catch (e) {
      print("USER VIEW MODEL SIGN OUT ERROR $e");
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      state = ViewState.BUSY;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      print("USER VIEW MODEL GOOGLE SIGN IN ERROR $e");
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      if (_emailPasswordCheck(email, password)) {
        state = ViewState.BUSY;
        _user = await _userRepository.signInWithEmail(email, password);
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      print("USER VIEW MODEL EMAIL SIGN IN ERROR $e");
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<UserModel?> signUpWithEmail(
      String email, String password, String? userName) async {
    if (_emailPasswordCheck(email, password)) {
      try {
        _user =
            await _userRepository.signUpWithEmail(email, password, userName);
        state = ViewState.BUSY;

        return _user;
      } finally {
        state = ViewState.IDLE;
      }
    } else {
      return null;
    }
  }

  bool _emailPasswordCheck(String email, String password) {
    bool result = true;

    if (password.length < 6) {
      passwordErrorMessage = "password lenght must be minimum 6 character";
      result = false;
    } else {
      passwordErrorMessage = null;
    }

    if (!email.contains("@") || !email.contains(".")) {
      emailErrorMessage = "please enter a valid email address";
      result = false;
    } else {
      emailErrorMessage = null;
    }

    return result;
  }

  void updateUserName(String newUserName, String userId) {
    _userRepository.updateUserName(newUserName, userId);
  }

  Future<String> updateProfilePhoto(
      String userId, String fileType, File file) async {
    return await _userRepository.updateProfilePhoto(userId, fileType, file);
  }

  Future<List<UserModel>> getAllUsers() async {
    allUsers = await _userRepository.getAllUsers();
    return allUsers;
  }

  Stream<List<MessageModel>> getMessages({
    required String currentUser,
    required String interlocutor,
  }) {
    return _userRepository.getMessages(
      currentUser: currentUser,
      interlocutor: interlocutor,
    );
  }

  Future<void> saveMessage(MessageModel message) async {
    await _userRepository.saveMessage(message);
  }

  Future<List<ChatModel>> getConversations(String userId) async {
    return await _userRepository.getConversations(userId);
  }

  UserModel getUserFromCache(String userId) {
    for (UserModel user in allUsers) {
      if (user.userId == userId) {
        return user;
      }
    }
    return _userRepository.getUser(userId);
  }

  Future<DateTime> getCurrentTime(String userId) async {
    return _userRepository.getCurrentTime(userId);
  }
}
