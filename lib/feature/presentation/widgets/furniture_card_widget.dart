import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/furniture_detail_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FurnitureCardWidget extends StatelessWidget {
  final FurnitureEntity furniture;
  const FurnitureCardWidget({Key? key, required this.furniture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FurnitureDetailPage(furniture: furniture)));
          },
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
                    imageUrl: furniture.image!
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(furniture.name!, style: GoogleFonts.mPlus1p(fontSize: 20)),
                      ),
                      const SizedBox(width: 10,),
                      Text('Цена: ${furniture.price} ₽', style: const TextStyle(fontSize: 15)),
                    ]),
                ),
            ],
      ),
          ),
        ),
    );
  }
}
