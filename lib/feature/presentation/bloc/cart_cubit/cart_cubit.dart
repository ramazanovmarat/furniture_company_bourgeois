import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/cart/add_cart.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/cart/clear_cart.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/cart/get_cart.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddCartUseCase addCartUseCase;
  final ClearCartUseCase clearCartUseCase;
  CartCubit({required this.clearCartUseCase, required this.addCartUseCase, required this.getCartUseCase}) : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final cartResponse = getCartUseCase.call();
      cartResponse.listen((carts) => emit(CartLoaded(carts: carts)));
    } on SocketException catch (_) {
      print('Get Failure');
    } catch (_) {
      print('Get Failure');
    }
  }

  Future<void> addCart({required FurnitureEntity furniture}) async {
    try {
      await addCartUseCase.call(furniture);
    } on SocketException catch (_) {
      print('Add Failure');
    } catch (_) {
      print('Add Failure');
    }
  }

  Future<void> clearCart() async {
    try {
      await clearCartUseCase.call();
    } on SocketException catch (_) {
      emit(CartFailure());
    } catch (_) {
      emit(CartFailure());
    }
  }
}