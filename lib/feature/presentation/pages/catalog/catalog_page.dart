import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/catalog/gostinnaya.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/catalog/kychnya.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/catalog/spalnya.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

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
            KitchenFurniture(),
            LivingRoomFurniture(),
            BedroomFurniture(),
          ],
        ),
      ),
    );
  }
}
