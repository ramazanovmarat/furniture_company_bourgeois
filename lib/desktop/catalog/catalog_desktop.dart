import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/desktop/catalog/bedroom.dart';
import 'package:furniture_company_bourgeois/desktop/catalog/kitchen.dart';
import 'package:furniture_company_bourgeois/desktop/catalog/living_room.dart';

class CatalogDesktop extends StatelessWidget {
  const CatalogDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text('Каталог', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorWeight: 5,
            tabs: [
              Tab(text: 'Кухонная'),
              Tab(text: 'Гостинная'),
              Tab(text: 'Спальня'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Kitchen(),
            LivingRoom(),
            Bedroom(),
          ],
        ),
      ),
    );
  }
}
