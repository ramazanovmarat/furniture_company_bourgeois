import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/furniture_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/furniture_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/furniture_detail_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_card_widget.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FurnitureCubit, FurnitureState>(
        builder: (context, state) {
          if(state is FurnitureLoaded) {
            final filterFurniture = state.furnitures.where((furniture) =>
                furniture.name!.startsWith(_searchController.text) ||
                    furniture.name!.toLowerCase().startsWith(_searchController.text.toLowerCase()) ||
                    furniture.name!.contains(_searchController.text) ||
                    furniture.name!.toLowerCase().contains(_searchController.text.toLowerCase())
            ).toList();
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                children: [
                  SearchWidget(controller: _searchController),
                  const SizedBox(height: 10),
                  _searchController.text.isNotEmpty && filterFurniture.isNotEmpty
                      ? Expanded(child: ListView.builder(
                      itemCount: filterFurniture.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => FurnitureDetailPage(furniture: filterFurniture[index])));
                          },
                          child: FurnitureCardWidget(furniture: filterFurniture[index]),
                        );
                      }))
                      : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset('assets/images/search.png', height: 200, width: 200),
                      ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
