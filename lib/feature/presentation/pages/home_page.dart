import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/search_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_list_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text('Bourgeois', style: GoogleFonts.cinzel(fontSize: 25, color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const SearchPage()));
              },
              icon: const Icon(Icons.search_outlined, color: Colors.black),
          ),
        ],
      ),
      body: const FurnitureList(),
    );
  }
}
