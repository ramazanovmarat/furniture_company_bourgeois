
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/cart_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/shopping/add_shopping.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/shopping/get_shopping.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/shopping_cubit/shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  final AddShoppingUseCase addShoppingUseCase;
  final GetShoppingUseCase getShoppingUseCase;

  ShoppingCubit({
    required this.addShoppingUseCase,
    required this.getShoppingUseCase
  }) : super(ShoppingInitial());

  Future<void> addShopping() async {
    try {
      await addShoppingUseCase.call();
    } on SocketException catch (_) {
      print('Error');
    } catch (_) {
      print('Error');
    }
  }

  Future<void> getShopping() async {
    emit(ShoppingLoading());
    try {
      final shoppingResponse = getShoppingUseCase.call();
      shoppingResponse.listen((shoppings) => emit(ShoppingLoaded(shoppings: shoppings)));
    } on SocketException catch (_) {
      print('Error');
    } catch (_) {
      print('Error');
    }
  }
}