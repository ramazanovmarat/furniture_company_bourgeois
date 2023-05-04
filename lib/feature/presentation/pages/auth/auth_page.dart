import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/auth/sign_in_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/auth/sign_up_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthProfilePage extends StatelessWidget {
  const AuthProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FadeInAnimation(
           delay: 0.8,
            child: Stack(children: [
              const Image(
            image: AssetImage('assets/images/fon.jpg'),
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text('Bourgeois', style: GoogleFonts.cinzel(fontSize: 45, color: Colors.white)),
                  const Text('Мебель для вашего дома', style: TextStyle(color: Colors.white, fontSize: 15)),
                  const SizedBox(height: 150),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignInPage()));
                      },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20)),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.white, width: 3)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    ),
                      child: const Text('Войти', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignUpPage()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                          horizontal: 38,
                          vertical: 20)),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.white, width: 3)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: const Text('Зарегистрироваться', style: TextStyle(fontSize: 18)),
                  ),
                ]),
              ),
        ]),
      )),
    );
  }
}
