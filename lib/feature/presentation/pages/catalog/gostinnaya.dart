import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/catalog/detail_page/living_room_deatail_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_cache_image_widget.dart';

class LivingRoomFurniture extends StatelessWidget {
  const LivingRoomFurniture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("livingRoom").snapshots(),
        builder: (context, snapshot) {
          return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                final QueryDocumentSnapshot doc = snapshot.data!.docs[index];

                final LivingRoomEntity livingRoomEntity = LivingRoomEntity(
                  image: doc['image'],
                  description: doc['description'],
                  name: doc['name'],
                  price: doc['price'],
                );

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => LivingRoomDetailPage(livingRoomEntity: livingRoomEntity)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        FurnitureCacheImage(
                          height: 160,
                          imageUrl: livingRoomEntity.image!,
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class LivingRoomEntity extends Equatable {
  final String? uid;
  final String? image;
  final String? description;
  final String? name;
  final num? price;

  const LivingRoomEntity({this.uid, this.image, this.description, this.name, this.price});

  @override
  // TODO: implement props
  List<Object?> get props => [
    uid,
    image,
    description,
    name,
    price,
  ];
}
