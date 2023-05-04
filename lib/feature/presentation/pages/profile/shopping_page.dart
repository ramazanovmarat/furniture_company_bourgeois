import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/shopping_cubit/shopping_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/shopping_cubit/shopping_state.dart';
import 'package:furniture_company_bourgeois/feature/presentation/widgets/shopping_widget.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text('Покупки', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: BlocBuilder<ShoppingCubit, ShoppingState> (
        builder: (context, state) {
          if(state is ShoppingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is ShoppingFailure) {
            return const Center(child: Text('Error'));
          }
          if(state is ShoppingLoaded) {
            return ListView.builder(
                itemCount: state.shoppings.length,
                itemBuilder: (context, index) {
                  final shop = state.shoppings[index];
                  return ShoppingWidget(shoppingFurniture: shop);
            });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
