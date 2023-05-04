import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:furniture_company_bourgeois/desktop/main_bottom.dart';

class DesktopSignUp extends StatefulWidget {
  const DesktopSignUp({Key? key}) : super(key: key);

  @override
  State<DesktopSignUp> createState() => _DesktopSignUpState();
}

class _DesktopSignUpState extends State<DesktopSignUp> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _handleSignUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final User user = await auth.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      Navigator.push(context,
          MaterialPageRoute(builder: (_) => MainBottomDesktop(user: user)));
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
          title: Text('Register'),
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
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(hintText: 'Потвердите пароль'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Пожалуйста, потвердите пароль';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
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
                              _handleSignUp();
                            }
                          },
                          child: const Text('Зарегистрироваться'),
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
