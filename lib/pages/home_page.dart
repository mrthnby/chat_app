
import 'package:chat_app/pages/profile_page.dart';
import 'package:chat_app/pages/users_page.dart';
import 'package:flutter/material.dart';

import '../services/tab_item.dart';
import '../widgets/custom_button_navigation_bar.dart';
import 'current_chats_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.users;
  Map<TabItem, Widget> allPages() {
    return {
      TabItem.profile: const ProfilePage(),
      TabItem.chats: const ChatsScreen(),
      TabItem.users: const UsersPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return CustomNavigation(
      pageGenerator: allPages(),
      currentTab: _currentTab,
      onTabSelect: (value) {
        setState(() {
          _currentTab = value;
        });
      },
    );
  }
}
