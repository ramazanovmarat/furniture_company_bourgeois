import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/favorite_entity.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteList extends StatefulWidget {
  final FavoriteEntity favoriteEntity;
  const FavoriteList({Key? key, required this.favoriteEntity}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {

  bool _addCart = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12)
        ),
        child: Column(
          children: [
            FurnitureCacheImage(
                height: 300,
                imageUrl: widget.favoriteEntity.image!
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  children: [
                    Expanded(
                      child: Text(widget.favoriteEntity.name!, style: GoogleFonts.mPlus1p(fontSize: 20)),
                    ),
                    const SizedBox(width: 10,),
                    Text('Цена: ${widget.favoriteEntity.price} ₽', style:const TextStyle(fontSize: 15)),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                // height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    onPressed: _addCart ? null : () {
                      setState(() {
                        _addCart = true;
                      });
                      sendDataFromOneCollectionToAnother(widget.favoriteEntity);
                    },
                    child: Text(_addCart ? 'Добавлен в корзину' : 'Добавить в корзину', style: const TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ]),
      ),
    );
  }
}

Future sendDataFromOneCollectionToAnother(FavoriteEntity favoriteEntity) async {

  await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("cart").add({
    "postID" : favoriteEntity.postID,
    "image" : favoriteEntity.image,
    "name" : favoriteEntity.name,
    "description" : favoriteEntity.description,
    "price" : favoriteEntity.price,
  });


}