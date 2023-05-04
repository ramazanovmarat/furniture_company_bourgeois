import 'dart:math';

import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/desktop/detail.dart';
import 'package:google_fonts/google_fonts.dart';

import '../feature/presentation/widgets/furniture_cache_image_widget.dart';

class SearchPageDesktop extends StatefulWidget {
  final List<Map<String, dynamic>> furniture;
  const SearchPageDesktop({Key? key, required this.furniture}) : super(key: key);

  @override
  State<SearchPageDesktop> createState() => _SearchPageDesktopState();
}

class _SearchPageDesktopState extends State<SearchPageDesktop> {

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = widget.furniture;
  }

  void _searchFurniture(String query) {
    final results = widget.furniture.where((furniture) =>
        furniture['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()));
    setState(() {
      _searchResults = results.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text('Поиск мебели', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 300, right: 300),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black
                  ),
                ),
                  hintText: 'Search Furniture',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchResults = [];
                        });
                      },
                      icon: const Icon(Icons.clear))),
              onChanged: (query) {
                _searchFurniture(query);
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _searchController.text.isNotEmpty && _searchResults.isNotEmpty ? ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final furniture = _searchResults[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 150, right: 150, bottom: 20),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
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
                  ),
                );
              },
            ) : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset('assets/images/search.png', height: 200, width: 200),
            ),
          ),
        ],
      ),
    );
  }
}
