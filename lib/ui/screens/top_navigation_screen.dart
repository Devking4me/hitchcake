import 'package:flutter/material.dart';
import 'package:Hitchcake/data/model/top_navigation_item.dart';
import 'package:Hitchcake/ui/screens/top_navigation_screens/profile_screen.dart';
import 'top_navigation_screens/chats_screen.dart';
import 'top_navigation_screens/match_screen.dart';

class TopNavigationScreen extends StatelessWidget {
  static const String id = 'top_navigation_screen';
  final List<TopNavigationItem> navigationItems = [
    TopNavigationItem(
      screen: ChatsScreen(),
      iconData: Icons.mail_outlined,
    ),
    TopNavigationItem(
      screen: MatchScreen(),
      iconData: Icons.favorite,
    ),
    TopNavigationItem(
      screen: ProfileScreen(),
      iconData: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var tabBar = TabBar(
      unselectedLabelColor: Colors.grey,
      labelColor: Color.fromARGB(255, 115, 7, 63),
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 115, 7,
                63), // Set the color of the border for the active tab as required
            width:
                3.0, // Set the width of the border for the active tab as required
          ),
        ),
      ),
      tabs: navigationItems
          .map((navItem) => Container(
              height: double.infinity,
              child: Tab(icon: Icon(navItem.iconData, size: 26))))
          .toList(),
    );

    var appBar = AppBar(
      flexibleSpace: tabBar,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

    return DefaultTabController(
      length: navigationItems.length,
      initialIndex: 1,
      child: SafeArea(
        child: Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height -
                  tabBar.preferredSize.height -
                  appBar.preferredSize.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: navigationItems
                        .map((navItem) => navItem.screen)
                        .toList()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
