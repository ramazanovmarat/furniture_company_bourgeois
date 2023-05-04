import 'package:equatable/equatable.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/favorite_entity.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteEntity> favorites;

  const FavoriteLoaded({required this.favorites});

  @override
  // TODO: implement props
  List<Object?> get props => [favorites];
}

class FavoriteFailure extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}