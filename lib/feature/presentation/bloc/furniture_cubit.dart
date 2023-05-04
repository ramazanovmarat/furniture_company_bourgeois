import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/get_all_furniture.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/furniture_state.dart';

class FurnitureCubit extends Cubit<FurnitureState> {
  final GetAllFurnitureUseCase getAllFurnitureUseCase;

  FurnitureCubit({required this.getAllFurnitureUseCase}) : super(FurnitureInitial());

  Future<void> getAllFurniture({required FurnitureEntity furniture}) async {
    emit(FurnitureLoading());
    try {
      final streamResponse = getAllFurnitureUseCase.call(furniture);
      streamResponse.listen((furnitures) {
        emit(FurnitureLoaded(furnitures: furnitures));
      });
    } on SocketException catch (_) {
      emit(FurnitureFailure());
    } catch (_) {
      emit(FurnitureFailure());
    }
  }
}