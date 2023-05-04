import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/favorite/clear_favorite.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/favorite/favorite.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/favorite/get_favorite.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/favorite_cubit/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteUseCase favoriteUseCase;
  final GetFavoriteUseCase getFavoriteUseCase;
  final ClearFavoriteUseCase clearFavoriteUseCase;

  FavoriteCubit({
      required this.favoriteUseCase,
      required this.getFavoriteUseCase,
      required this.clearFavoriteUseCase,
  }) : super(FavoriteInitial());

  Future<void> favorite({required FurnitureEntity furniture}) async {
    try {
      await favoriteUseCase.call(furniture);
    } on SocketException catch (_) {
      print('Add Failure');
    } catch (_) {
      print('Add Failure');
    }
  }

  Future<void> getFavorite() async {
    emit(FavoriteLoading());
    try {
      final favoriteResponse = getFavoriteUseCase.call();
      favoriteResponse.listen((favorites) => emit(FavoriteLoaded(favorites: favorites)));
    } on SocketException catch (_) {
      print('Get Failure');
    } catch (_) {
      print('Get Failure');
    }
  }

  Future<void> clearFavorite() async {
    try {
      await clearFavoriteUseCase.call();
    } on SocketException catch (_) {
      emit(FavoriteFailure());
    } catch (_) {
      emit(FavoriteFailure());
    }
  }
}