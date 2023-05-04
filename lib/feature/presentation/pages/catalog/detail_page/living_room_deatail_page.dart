import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/catalog/gostinnaya.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/furniture_cache_image_widget.dart';

class LivingRoomDetailPage extends StatefulWidget {
  final LivingRoomEntity livingRoomEntity;
  const LivingRoomDetailPage({Key? key, required this.livingRoomEntity}) : super(key: key);

  @override
  State<LivingRoomDetailPage> createState() => _LivingRoomDetailPageState();
}

class _LivingRoomDetailPageState extends State<LivingRoomDetailPage> {

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
              favorites(widget.livingRoomEntity);
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
                    FurnitureCacheImage(height: 300, imageUrl: widget.livingRoomEntity.image!),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.livingRoomEntity.name!, style: GoogleFonts.mPlus1p(fontSize: 22)),
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
                              addCarts(widget.livingRoomEntity);
                            },
                            child: Text(_addCart ? 'в корзине' : 'в корзину', style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('${widget.livingRoomEntity.price!} ₽', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 15),
                    Text(widget.livingRoomEntity.description!),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}

Future<void> addCarts(LivingRoomEntity livingRoomEntity) async {
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").add({
    "postID" : livingRoomEntity.uid,
    "image" : livingRoomEntity.image,
    "name" : livingRoomEntity.name,
    "description" : livingRoomEntity.description,
    "price" : livingRoomEntity.price,
  });
}

Future<void> favorites(LivingRoomEntity livingRoomEntity) async {
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("favorite").add({
    "postID" : livingRoomEntity.uid,
    "image" : livingRoomEntity.image,
    "name" : livingRoomEntity.name,
    "description" : livingRoomEntity.description,
    "price" : livingRoomEntity.price,
  });
}