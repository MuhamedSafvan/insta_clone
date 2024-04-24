import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    print(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // UserModel? user = Provider.of<UserProvider>(context).getUser;
    return Consumer<UserProvider>(builder: (context, model, _) {
      model.getUser;
      return Scaffold(
        body: PageView(
          children: homeScreenPages,
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(onTap: navigationTapped, items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.home,
            color: _page == 0 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.search,
            color: _page == 1 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.add_circle,
            color: _page == 2 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.favorite,
            color: _page == 3 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.person,
            color: _page == 4 ? primaryColor : secondaryColor,
          )),
        ]),
      );
    });
  }
}
