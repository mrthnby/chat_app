import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../viewmodel/user_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/message_box.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;
  final UserModel interlocutor;
  const ChatPage({super.key, required this.user, required this.interlocutor});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    ScrollController scrollController = ScrollController();
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserModel user = widget.user;
    UserModel interlocutor = widget.interlocutor;
    return Container(
      color: const Color.fromRGBO(250, 250, 250, 1),
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(120.0),
                child: Material(
                  elevation: 1,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: widget.interlocutor.profilePic! != ""
                            ? NetworkImage(widget.interlocutor.profilePic!)
                            : Image.asset("assets/profile_pic.jpg").image,
                      ),
                      Text(
                        widget.interlocutor.userName!,
                      ),
                    ],
                  ),
                )),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                    stream: userViewModel.getMessages(
                      currentUser: user.userId,
                      interlocutor: interlocutor.userId,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        controller: scrollController,
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          MessageModel currentmessage = snapshot.data![index];
                          return MessageBox(
                            message: currentmessage,
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "Type a message!",
                          noPadding: true,
                          radius: 25,
                          textEditingController: textEditingController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FloatingActionButton(
                          onPressed: () async {
                            if (textEditingController.text.trim().isNotEmpty) {
                              String currentMessage =
                                  textEditingController.text;
                              textEditingController.clear();
                              await userViewModel.saveMessage(
                                MessageModel(
                                  from: user.userId,
                                  to: interlocutor.userId,
                                  content: currentMessage,
                                  isFromMe: true,
                                ),
                              );
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 10),
                                curve: Curves.bounceIn,
                              );
                            }
                          },
                          elevation: 0,
                          child: const Icon(
                            Icons.send_rounded,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
