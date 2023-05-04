import 'package:equatable/equatable.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';

abstract class FurnitureState extends Equatable {
  const FurnitureState();
}

class FurnitureInitial extends FurnitureState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FurnitureLoading extends FurnitureState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FurnitureLoaded extends FurnitureState {
  final List<FurnitureEntity> furnitures;

  const FurnitureLoaded({required this.furnitures});

  @override
  // TODO: implement props
  List<Object?> get props => [furnitures];
}

class FurnitureFailure extends FurnitureState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}