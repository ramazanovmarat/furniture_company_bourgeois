import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/favorite_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/cart_cubit/cart_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FurnitureDetailPage extends StatefulWidget {
  final FurnitureEntity furniture;
  const FurnitureDetailPage({Key? key, required this.furniture}) : super(key: key);

  @override
  State<FurnitureDetailPage> createState() => _FurnitureDetailPageState();
}

class _FurnitureDetailPageState extends State<FurnitureDetailPage> {

  FavoriteEntity favoriteEntity = const FavoriteEntity();
  bool _addCart = false;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() => isFavorite = !isFavorite);
                context.read<FavoriteCubit>().favorite(furniture: widget.furniture);
              },
              icon: isFavorite
                  ? const Icon(Icons.bookmark_outlined, color: Colors.black)
                  : const Icon(Icons.bookmark_border_outlined, color: Colors.black),
          ),
        ],
      ),
      body: FadeInAnimation(
        delay: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FurnitureCacheImage(height: 300, imageUrl: widget.furniture.image!),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.furniture.name!, style: GoogleFonts.mPlus1p(fontSize: 22)),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.orange),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))
                          ),
                          onPressed: _addCart ? null : () {
                              setState(() {
                                _addCart = true;
                              });
                              context.read<CartCubit>().addCart(furniture: widget.furniture);
                          },
                          child: Text(_addCart ? 'в корзине' : 'в корзину', style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('${widget.furniture.price!} ₽', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 15),
                  Text(widget.furniture.description!),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}
