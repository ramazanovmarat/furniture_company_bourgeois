import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/get_single_user_cubit/get_single_user_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/catalog/catalog_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/home_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/profile/profile_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/shopping_card_page.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, getSingleUserState) {
          if (getSingleUserState is GetSingleUserLoaded) {
            final currentUser = getSingleUserState.user;
            return CupertinoTabScaffold(
              backgroundColor: Colors.white,
              tabBar: CupertinoTabBar(
                activeColor: Colors.orange,
                inactiveColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.store_outlined)),
                  BottomNavigationBarItem(icon: Icon(Icons.view_cozy_outlined)),
                  BottomNavigationBarItem(icon: Icon(Icons.local_mall_outlined)),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outlined)),
                ],
              ),
              tabBuilder: (BuildContext context, int index) {
                switch(index) {
                  case 0:
                    return CupertinoTabView(
                      builder: (context) {
                        return const CupertinoPageScaffold(child: HomePage());
                      },
                    );
                  case 1:
                    return CupertinoTabView(
                      builder: (context) {
                        return CupertinoPageScaffold(child: CatalogPage());
                      },
                    );
                  case 2:
                    return CupertinoTabView(
                      builder: (context) {
                        return const CupertinoPageScaffold(child: ShoppingCardPage());
                      },
                    );
                  case 3:
                    return CupertinoTabView(
                      builder: (context) {
                        return CupertinoPageScaffold(child: ProfilePage(userEntity: currentUser));
                      },
                    );
                }
                return const SizedBox();
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }
}
