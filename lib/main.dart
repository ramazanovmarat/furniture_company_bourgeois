
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_company_bourgeois/const.dart';
import 'package:furniture_company_bourgeois/desktop/auth/desktop_auth_page.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/cart_cubit/cart_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/credential_cubit/credential_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/furniture_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/shopping_cubit/shopping_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/auth/auth_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/main_screen.dart';
import 'locator_service.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Platform.isWindows
      ? desktopApp()
      : mobileApp();
}

void desktopApp() async {
  final TokenStore tokenStore = VolatileStore();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.initialize(apiKey, tokenStore);
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: DesktopAuth()));
}

void mobileApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<FurnitureCubit>()..getAllFurniture(furniture: const FurnitureEntity())),
          BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
          BlocProvider(create: (_) => di.sl<CredentialCubit>()),
          BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
          BlocProvider(create: (_) => di.sl<CartCubit>()..getCart()),
          BlocProvider(create: (_) => di.sl<FavoriteCubit>()..getFavorite()),
          BlocProvider(create: (_) => di.sl<ShoppingCubit>()..getShopping()),
        ],
        child: MaterialApp(
          color: Colors.white,
          title: 'Bourgeois',
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    return MainScreen(uid: authState.uid,);
                  } else {
                    return const AuthProfilePage();
                  }
                },
              );
            }
          },
        ),
    );
  }
}


