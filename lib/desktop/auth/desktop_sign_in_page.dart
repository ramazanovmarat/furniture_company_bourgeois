import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:furniture_company_bourgeois/desktop/main_bottom.dart';

class DesktopSignIn extends StatefulWidget {
  const DesktopSignIn({Key? key}) : super(key: key);

  @override
  State<DesktopSignIn> createState() => _DesktopSignInState();
}

class _DesktopSignInState extends State<DesktopSignIn> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final User user = await auth.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainBottomDesktop(user: user)));
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Login'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Пожалуйста, введите почту';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Пароль'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Пожалуйста, введите пароль';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                       onPressed: () {
                       if (_formKey.currentState!.validate()) {
                       _handleSignIn();
                    }
                  },
                     child: const Text('Войти'),
                ),
                const SizedBox(height: 10.0),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
