import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class BedRoomDetail extends StatefulWidget {
  final Map<String, dynamic> bedRoom;
  const BedRoomDetail({Key? key, required this.bedRoom}) : super(key: key);

  @override
  State<BedRoomDetail> createState() => _BedRoomDetailState();
}

class _BedRoomDetailState extends State<BedRoomDetail> {

  bool addCart = false;
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FurnitureCacheImage(height: 600, width: 600, imageUrl: widget.bedRoom['image']),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.bedRoom['name'], style: GoogleFonts.mPlus1p(fontSize: 40)),
                          const SizedBox(height: 20),
                          Text('${widget.bedRoom['price']} ₽', style: const TextStyle(fontSize: 30)),
                          const SizedBox(height: 20),
                          const Divider(),
                          Text(widget.bedRoom['description'], style: const TextStyle(fontSize: 20)),
                          const Divider(),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))
                              ),
                              onPressed: addCart ? null : () {
                                setState(() {
                                  addCart = true;
                                });

                              },
                              child: Text(addCart ? 'в корзине' : 'в корзину', style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}
