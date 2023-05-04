import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/profile_cache_image.dart';

class DesktopProfile extends StatelessWidget {
  final User user;
  const DesktopProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text('Профиль', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {},
              child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: profileWidget(imageUrl: user.photoUrl),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${user.email}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          const Text('Управление аккаунтом'),
                        ]),
                    const Expanded(child: Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios))),
                  ]),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.delivery_dining_outlined),
                        SizedBox(width: 15),
                        Text('Доставка', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: () {},
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
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
