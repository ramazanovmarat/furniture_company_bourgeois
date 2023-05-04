import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/cart_cubit/cart_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/cart_cubit/cart_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_details_page.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/cart_card.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/fade_in_animation.dart';

class ShoppingCardPage extends StatefulWidget {
  const ShoppingCardPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCardPage> createState() => _ShoppingCardPageState();
}

class _ShoppingCardPageState extends State<ShoppingCardPage> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text('Корзина', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () => showDialog(context: context, builder: (_) => const AlertDialogCustom()),
                icon: const Icon(Icons.delete, color: Colors.black)),
          ],
        ),
      body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if(state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if(state is CartFailure) {
              return const Center(child: Text('Error'));
            }
            if (state is CartLoaded) {
              return state.carts.isEmpty
              ? Image.asset('assets/images/empty_cart.png')
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.carts.length,
                  itemBuilder: (context, index) {
                    final cart = state.carts[index];
                    return FadeInAnimation(
                        delay: 0.8, child: CartCard(cart: cart));
                  });
        }
        return const SizedBox();
          }
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if(state is CartLoaded) {
            return state.carts.isNotEmpty ? Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaymentDetailsPage()));
                },
                child: _sumTotalCart(title: 'К оплате'),
              ),
            ) : const SizedBox();
          }
          return const SizedBox();
        },
      ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     elevation: 0.0,
    //     title: const Text('Корзина', style: TextStyle(color: Colors.black)),
    //     centerTitle: true,
    //     actions: [
    //       IconButton(onPressed: () async {
    //         final collection = await FirebaseFirestore.instance
    //             .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").get();
    //         final batch = FirebaseFirestore.instance.batch();
    //         for(final doc in collection.docs) {
    //           batch.delete(doc.reference);
    //         }
    //         return batch.commit();
    //       },
    //           icon: const Icon(Icons.delete, color: Colors.black,)),
    //     ],
    //   ),
    //   body: StreamBuilder<QuerySnapshot>(
    //       stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").snapshots(),
    //       builder: (context, snapshot) {
    //         if(snapshot.hasError) {
    //           return const Center(child: Text("Error"));
    //         }
    //         if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
    //           return const Center(child: CircularProgressIndicator());
    //         }
    //
    //         return ListView.builder(
    //             itemCount: snapshot.data?.docs.length,
    //             itemBuilder: (context, index) {
    //
    //               final QueryDocumentSnapshot doc = snapshot.data!.docs[index];
    //
    //               final CartEntity cartEntity = CartEntity(
    //                 postID: doc["postID"],
    //                 image: doc["image"],
    //                 name: doc["name"] ?? 0,
    //                 description: doc["description"],
    //                 price: doc["price"],
    //               );
    //
    //               return CartCard(cart: cartEntity);
    //             }
    //         );
    //       }
    //   ),
    // );
  }
}

Widget _sumTotalCart({required String title}) {
  return FutureBuilder(
    future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").get(),
    builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      num sumTotal = 0;
      if(snapshot.connectionState == ConnectionState.done) {
        for (var element in snapshot.data!.docs) {
          num value = element["price"];
          sumTotal = sumTotal + value;
        }
        return Text('$title $sumTotal ₽');
      }
      return Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator());
    },
  );
}


class AlertDialogCustom extends StatefulWidget {
  const AlertDialogCustom({super.key});

  @override
  State<StatefulWidget> createState() => AlertDialogCustomState();
}

class AlertDialogCustomState extends State<AlertDialogCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.addListener(() => setState(() {}));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Вы точно хотите очистить корзину?", style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text('Нет', style: TextStyle(fontSize: 17))),
                      const SizedBox(width: 20),
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                        context.read<CartCubit>().clearCart();
                      },
                          child: const Text('Да', style: TextStyle(fontSize: 17))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

