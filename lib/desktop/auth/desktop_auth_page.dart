import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/desktop/auth/desktop_sign_in_page.dart';
import 'package:furniture_company_bourgeois/desktop/auth/desktop_sign_up.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopAuth extends StatelessWidget {
  const DesktopAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInAnimation(
        delay: 0.8,
        child: Stack(children: [
          const Image(
            image: AssetImage('assets/images/background_desktop.jpg'),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DesktopSignIn()));
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DesktopSignUp()));
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
      )
    );
  }
}
