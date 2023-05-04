import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/credential_cubit/credential_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/credential_cubit/credential_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/main_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            print("Invalid Email and Password");
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                hintText: 'Пароль',
              ),
            ),
            const SizedBox(height: 10),
            _signInNavigate(),
            const SizedBox(height: 10),
            _isSigningIn == true ? Row(
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
    );
  }

  _signInNavigate() {
    return ElevatedButton(
      onPressed: (){
        setState(() {
          _isSigningIn = true;
        });
        BlocProvider.of<CredentialCubit>(context).signInUser(
          email: _emailController.text,
          password: _passwordController.text,
        ).then((value) => _clear());
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 60, vertical: 18)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(Colors.black),
        side: MaterialStateProperty.all(const BorderSide(
            color: Colors.black)),
      ),
      child: const Text('Войти', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSigningIn = false;
    });
  }

}





