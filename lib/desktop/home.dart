import 'dart:math';
import 'package:firedart/firestore/firestore_gateway.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:furniture_company_bourgeois/const.dart';
import 'package:furniture_company_bourgeois/desktop/detail.dart';
import 'package:furniture_company_bourgeois/desktop/search_page_desktop.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopApp extends StatefulWidget {
  @override
  _DesktopAppState createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {

  final _client = FirestoreGateway(projectId);

  @override
  void initState() {
    super.initState();
    _loadFurniture();
  }

  List<Map<String, dynamic>> _furniture = [];

  void _loadFurniture() async {
    final collection = CollectionReference(_client, 'furniture');
    final documents = await collection.get();
    final furniture = documents.map((doc) => doc.map).toList();
    setState(() {
      _furniture = furniture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bourgeois',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text('Bourgeois', style: TextStyle(color: Colors.black, fontSize: 30)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPageDesktop(furniture: _furniture)));
                },
                icon: const Icon(Icons.search_outlined, color: Colors.black),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: _furniture.length,
            itemBuilder: (context, index) {
              final furniture = _furniture[index];
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 150, right: 150, bottom: 20),
                child: InkWell(
                  hoverColor: Colors.grey,
                  splashColor: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(furniture: furniture)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(Random().nextInt(0xffffffff)),
                          Color(Random().nextInt(0xffffffff)),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        FurnitureCacheImage(
                          width: 400,
                          height: 400,
                          imageUrl: furniture['image'],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                furniture['name'],
                                  style: GoogleFonts.mPlus1p(fontSize: 50)
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                '${furniture['price']} ₽',
                                style: const TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}