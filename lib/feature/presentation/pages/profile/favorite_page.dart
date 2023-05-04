import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/favorite_cubit/favorite_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/favorite_list_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text('Избранное', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios), color: Colors.black),
        actions: [
          IconButton(
              onPressed: () => showDialog(context: context, builder: (_) => const AlertDialogCustom()),
              icon: const Icon(Icons.delete), color: Colors.black),
        ],
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteFailure) {
            return const Center(child: Text('Error'));
          }
          if (state is FavoriteLoaded) {
            return state.favorites.isEmpty
                ? const Center(child: Text('Добавь в избранное, чтобы не потерять', style: TextStyle(fontSize: 16)))
                : ListView.builder(
                    itemCount: state.favorites.length,
                    itemBuilder: (context, index) {
                      final favorite = state.favorites[index];
                      return FavoriteList(favoriteEntity: favorite);
                    });
          }
          return const SizedBox();
        },
      ),
    );
  }
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
                  const Text("Вы точно хотите очистить избранное?", style: TextStyle(fontSize: 17)),
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
                        context.read<FavoriteCubit>().clearFavorite();
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
