import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../viewmodel/user_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/platform_sensitive_allertdialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _textEditingController;
  late TextEditingController _emailTextEditingController;
  File? _choosenPhoto;
  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserModel user = userViewModel.user!;
    _textEditingController =
        TextEditingController(text: user.userName ?? "Guest");
    _emailTextEditingController = TextEditingController(text: user.email);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(.7),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 160,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt_rounded),
                          title: const Text("Take a photo"),
                          onTap: () async {
                            XFile? tempFile = await _imagePicker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              Navigator.pop(context);
                              _choosenPhoto = File(tempFile!.path);
                            });
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.image_rounded),
                          title: const Text("Chose from gallery"),
                          onTap: () async {
                            XFile? tempFile = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              Navigator.pop(context);
                              _choosenPhoto = File(tempFile!.path);
                            });
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 90,
              backgroundImage: Image(
                fit: BoxFit.fill,
                image: _choosenPhoto != null
                    ? FileImage(_choosenPhoto!)
                    : user.profilePic == "" || user.profilePic == null
                        ? Image.asset("assets/profile_pic.jpg").image
                        : NetworkImage(user.profilePic!),
              ).image,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          user.userName == null
              ? const Text("Guest")
              : Text("${user.userName}"),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            textEditingController: _emailTextEditingController,
            readOnly: true,
            hintText: "Email",
            keyboardType: TextInputType.text,
            onSaved: (String? value) {},
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            textEditingController: _textEditingController,
            keyboardType: TextInputType.text,
            onChanged: ((value) {
              _textEditingController.text = value!;
            }),
            hintText: '',
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (_textEditingController.text != user.userName) {
                _updateUserName(userViewModel, context);
              }
              if (_choosenPhoto != null) {
                _updatePhoto(userViewModel, _choosenPhoto!);
              }
            },
            child: const Text(" Update "),
          ),
          ElevatedButton(
            onPressed: () => _logOut(userViewModel),
            child: const Text("Sign Out"),
          ),
        ],
      )),
    );
  }

  _logOut(
    UserViewModel userViewModel,
  ) async {
    await userViewModel.signOut();
  }

  _updateUserName(UserViewModel userViewModel, BuildContext context) {
    PlatformSensitiveAlertDialog(
      title: "Success",
      content: "Your username has been changed successfully ",
      actions: [
        ElevatedButton(
          onPressed: (() {
            Navigator.of(context, rootNavigator: true).pop();
          }),
          child: const Text("Close"),
        )
      ],
    ).show(context);
    userViewModel.user!.userName = _textEditingController.text;
    setState(() {});
    userViewModel.updateUserName(
      _textEditingController.text,
      userViewModel.user!.userId,
    );
  }

  _updatePhoto(UserViewModel userViewModel, File file) {
    userViewModel.updateProfilePhoto(
        userViewModel.user!.userId, "profile_photo", file);
    setState(() {});
  }
}
