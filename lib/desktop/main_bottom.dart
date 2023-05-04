import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/desktop/catalog/catalog_desktop.dart';
import 'package:furniture_company_bourgeois/desktop/home.dart';
import 'package:furniture_company_bourgeois/desktop/profile/desktop_profile.dart';

class MainBottomDesktop extends StatefulWidget {
  final User user;
  const MainBottomDesktop({Key? key, required this.user}) : super(key: key);

  @override
  State<MainBottomDesktop> createState() => _MainBottomDesktopState();
}

class _MainBottomDesktopState extends State<MainBottomDesktop> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
        activeColor: Colors.orange,
        inactiveColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.view_cozy_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch(index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: DesktopApp());
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: CatalogDesktop());
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: DesktopProfile(user: widget.user));
              },
            );
        }
        return const SizedBox();
      },
    );
  }
}
