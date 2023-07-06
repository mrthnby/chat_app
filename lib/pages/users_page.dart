import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../viewmodel/user_viewmodel.dart';
import 'chat_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Users",
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: userViewModel.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length - 1 > 0) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                  await Future.delayed(
                    const Duration(
                      seconds: 1,
                    ),
                  );
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel currentUser = snapshot.data![index];
                    if (currentUser.userId == userViewModel.user!.userId) {
                      return Container();
                    }
                    return GestureDetector(
                      onTap: () =>
                          Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            user: userViewModel.user!,
                            interlocutor: currentUser,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: .4,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          color: Colors.deepPurple.shade100,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            title: Text(currentUser.userName!),
                            leading: CircleAvatar(
                                backgroundImage: currentUser.profilePic! != ""
                                    ? NetworkImage(currentUser.profilePic!)
                                    : Image.asset("assets/profile_pic.jpg")
                                        .image),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text("There is no user logged into the system."),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
