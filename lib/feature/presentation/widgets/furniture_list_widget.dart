import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/furniture_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/furniture_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/furniture_card_widget.dart';

class FurnitureList extends StatelessWidget {
  const FurnitureList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FurnitureCubit, FurnitureState>(
      builder: (context, state) {
        if(state is FurnitureLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if(state is FurnitureFailure) {
          return const Text('Error');
        }
        if (state is FurnitureLoaded) {
          return state.furnitures.isEmpty
              ? const Center(child: Text('No data'))
              : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.furnitures.length,
                itemBuilder: (context, index) {
                final furniture = state.furnitures[index];
                return FadeInAnimation(delay: 0.8, child: FurnitureCardWidget(furniture: furniture));
              }
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
    // return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection("furniture").snapshots(),
    //     builder: (context, snapshot) {
    //       if(snapshot.hasError) {
    //         return const Center(child: Text("Error"));
    //       }
    //       if(snapshot.connectionState == ConnectionState.waiting
    //           || snapshot.connectionState == ConnectionState.none) {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //
    //       return ListView.builder(
    //           itemCount: snapshot.data?.docs.length,
    //           itemBuilder: (context, index) {
    //
    //             final QueryDocumentSnapshot doc = snapshot.data!.docs[index];
    //
    //             final FurnitureEntity furnitureEntity = FurnitureEntity(
    //               uid: doc['uid'],
    //               image: doc['image'],
    //               name: doc['name'],
    //               description: doc['description'],
    //               price: doc['price']
    //             );
    //
    //             return Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: GestureDetector(
    //                 onTap: () {
    //                   Navigator.push(context, MaterialPageRoute(builder: (context) => FurnitureDetailPage(furniture: furnitureEntity)));
    //                 },
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       color: Colors.white10,
    //                       borderRadius: BorderRadius.circular(20),
    //                       border: Border.all(color: Colors.black12)
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       FurnitureCacheImage(
    //                           height: 300,
    //                           imageUrl: furnitureEntity.image!
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.all(10.0),
    //                         child: Row(
    //                             children: [
    //                               Expanded(
    //                                 child: Text(furnitureEntity.name!, style: GoogleFonts.mPlus1p(fontSize: 20)),
    //                               ),
    //                               const SizedBox(width: 10,),
    //                               Text('Цена: ${furnitureEntity.price} ₽', style:const TextStyle(fontSize: 15)),
    //                             ]),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           }
    //       );
    //     }
    // );
  }
}
