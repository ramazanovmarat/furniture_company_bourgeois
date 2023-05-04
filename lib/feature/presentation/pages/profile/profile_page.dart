import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/auth/auth_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/profile/edit_profile_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/profile/favorite_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/profile/shopping_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/profile_cache_image.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity userEntity;
  const ProfilePage({Key? key, required this.userEntity}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> _refresh(BuildContext context) async {
    return BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.userEntity.uid!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthProfilePage()), (Route<dynamic> route) => false);
          }
        },
        buildWhen: ((prev, current) {
          if (current is UnAuthenticated) {
            return false;
          }
          return true;
        }),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: const Text('Профиль', style: TextStyle(color: Colors.black)),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).loggedOut();
                    },
                    icon: const Icon(Icons.login, color: Colors.black)),
              ],
            ),
           body: RefreshIndicator(
            onRefresh: () {
              return _refresh(context);
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditProfile(userEntity: widget.userEntity)));
                          },
                          child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: profileWidget(imageUrl: widget.userEntity.profileUrl),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${widget.userEntity.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                      const Text('Управление аккаунтом'),
                                    ]),
                                const Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios))),
                              ]),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FavoritePage()));
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.bookmark_border_outlined),
                                  SizedBox(width: 15),
                                  Text('Избранное', style: TextStyle(fontSize: 17)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShoppingPage()));
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.local_mall_outlined),
                                  SizedBox(width: 15),
                                  Text('Покупки', style: TextStyle(fontSize: 17)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
