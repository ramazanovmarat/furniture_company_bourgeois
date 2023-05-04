import 'dart:math';

import 'package:firedart/firestore/firestore_gateway.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:furniture_company_bourgeois/const.dart';
import 'package:furniture_company_bourgeois/desktop/catalog/detail/kitchen_detail.dart';
import 'package:furniture_company_bourgeois/desktop/home.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({Key? key}) : super(key: key);

  @override
  State<Kitchen> createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {

  final _client = FirestoreGateway(projectId);

  @override
  void initState() {
    super.initState();
    _loadKitchen();
  }

  List<Map<String, dynamic>> _kitchen = [];

  void _loadKitchen() async {
    final collection = CollectionReference(_client, 'kitchen');
    final documents = await collection.get();
    final kitchen = documents.map((doc) => doc.map).toList();
    setState(() {
      _kitchen = kitchen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _kitchen.isNotEmpty ? GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _kitchen.length,
              itemBuilder: (context, index) {
                final kitchen = _kitchen[index];
                return InkWell(
                  hoverColor: Colors.grey,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => KitchenDetail(kitchen: kitchen)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FurnitureCacheImage(
                      height: 400,
                      width: 400,
                      imageUrl: kitchen['image'],
                    ),
                  ),
                );
              }) : Center(child: CircularProgressIndicator(color: Color(Random().nextInt(0xffffffff)))),
    );
  }
}
