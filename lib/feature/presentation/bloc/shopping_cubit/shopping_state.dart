import 'package:equatable/equatable.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/shopping_entity.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();
}

class ShoppingInitial extends ShoppingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShoppingLoading extends ShoppingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShoppingLoaded extends ShoppingState {
  final List<ShoppingEntity> shoppings;

  const ShoppingLoaded({required this.shoppings});

  @override
  // TODO: implement props
  List<Object?> get props => [shoppings];
}

class ShoppingFailure extends ShoppingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}