import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class AddCartUseCase {
  final FurnitureRepository furnitureRepository;

  AddCartUseCase({required this.furnitureRepository});

  Future<void> call(FurnitureEntity furniture) {
    return furnitureRepository.addCart(furniture);
  }
}