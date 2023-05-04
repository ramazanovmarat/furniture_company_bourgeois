import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/catalog/spalnya.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class BedroomDetailPage extends StatefulWidget {
  final BedroomEntity bedroomEntity;
  const BedroomDetailPage({Key? key, required this.bedroomEntity}) : super(key: key);

  @override
  State<BedroomDetailPage> createState() => _BedroomDetailPageState();
}


class _BedroomDetailPageState extends State<BedroomDetailPage> {

  bool _addCart = false;
  bool _isFavorite = false;

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
            onPressed: _isFavorite ? null : () {
              setState(() {
                _isFavorite = true;
              });
              favorites(widget.bedroomEntity);
            },
            icon: _isFavorite
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
                    FurnitureCacheImage(height: 300, imageUrl: widget.bedroomEntity.image!),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.bedroomEntity.name!, style: GoogleFonts.mPlus1p(fontSize: 22)),
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
                              addCarts(widget.bedroomEntity);
                            },
                            child: Text(_addCart ? 'в корзине' : 'в корзину', style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('${widget.bedroomEntity.price!} ₽', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 15),
                    Text(widget.bedroomEntity.description!),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}

Future<void> addCarts(BedroomEntity bedroomEntity) async {
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").add({
    "postID" : bedroomEntity.uid,
    "image" : bedroomEntity.image,
    "name" : bedroomEntity.name,
    "description" : bedroomEntity.description,
    "price" : bedroomEntity.price,
  });
}

Future<void> favorites(BedroomEntity bedroomEntity) async {
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("favorite").add({
    "postID" : bedroomEntity.uid,
    "image" : bedroomEntity.image,
    "name" : bedroomEntity.name,
    "description" : bedroomEntity.description,
    "price" : bedroomEntity.price,
  });
}