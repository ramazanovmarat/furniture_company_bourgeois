import 'package:equatable/equatable.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/cart_entity.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<CartEntity> carts;

  const CartLoaded({required this.carts});

  @override
  // TODO: implement props
  List<Object?> get props => [carts];
}

class CartFailure extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}