
import 'package:flutter/cupertino.dart';

import '../services/tab_item.dart';

class CustomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onTabSelect;
  final Map<TabItem, Widget> pageGenerator;
  const CustomNavigation({
    Key? key,
    required this.currentTab,
    required this.onTabSelect,
    required this.pageGenerator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _generateBarItem(TabItem.profile),
          _generateBarItem(TabItem.chats),
          _generateBarItem(TabItem.users),
        ],
        onTap: (index) => onTabSelect(
          TabItem.values[index],
        ),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return pageGenerator[TabItem.values[index]]!;
          },
        );
      },
    );
  }

  BottomNavigationBarItem _generateBarItem(TabItem currentTab) {
    final generatedTab = TabItemData.allTabs[currentTab];
    return BottomNavigationBarItem(
      icon: generatedTab!.icon,
      label: generatedTab.title,
    );
  }
}
