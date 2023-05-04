import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/credential_cubit/credential_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/credential_cubit/credential_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/main_screen.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/profile_cache_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isSigningUp = false;
  final bool _isUploading = false;

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch(e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            print('error');
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                } else {
                  return _bodyWidget();
                }
              },
            );
          }
          return _bodyWidget();
        },
      );
  }

  _bodyWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: selectImage,
                  child: Stack(
                      children: [
                        SizedBox(
                            height: 150,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: profileWidget(image: _image),
                            )),
                        const Positioned(
                            right: 15,
                            bottom: 15,
                            child: Icon(Icons.add_a_photo)
                        ),
                      ]),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Имя пользователя',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: 'Придумайте пароль',
                  ),
                ),
                const SizedBox(height: 10),
                _signInNavigate(),
                const SizedBox(height: 10),
                _isSigningUp == true || _isUploading == true ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Пожалуйста, подождите", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),),
                    SizedBox(width: 10),
                    CircularProgressIndicator()
                  ],
                ) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.emailVerified ?? false;
  }

  _signInNavigate() {
    return ElevatedButton(
      onPressed: () {
          setState(() {
            _isSigningUp = true;
          });
          BlocProvider.of<CredentialCubit>(context).signUpUser(
              user: UserEntity(
                email: _emailController.text,
                password: _passwordController.text,
                name: _usernameController.text,
                imageUrl: _image,
              )
          ).then((value) {
            _clear();
          });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 38, vertical: 20)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(Colors.black),
        side: MaterialStateProperty.all(const BorderSide(
            color: Colors.black)),
      ),
      child: const Text('Зарегистрироваться', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  _clear() {
    setState(() {
      _usernameController.clear();
      _bioController.clear();
      _emailController.clear();
      _passwordController.clear();
      _isSigningUp = false;
    });
  }
}


