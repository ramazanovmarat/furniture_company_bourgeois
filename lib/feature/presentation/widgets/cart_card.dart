import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/cart_entity.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CartCard extends StatelessWidget {
  final CartEntity cart;
  const CartCard({Key? key, required this.cart}) : super(key: key);

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
                imageUrl: cart.image!
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  children: [
                    Expanded(
                      child: Text(cart.name!, style: GoogleFonts.mPlus1p(fontSize: 20)),
                    ),
                    const SizedBox(width: 10,),
                    Text('Цена: ${cart.price} ₽', style:const TextStyle(fontSize: 15)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
