import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class FavoriteUseCase {
  final FurnitureRepository furnitureRepository;

  FavoriteUseCase({required this.furnitureRepository});

  Future<void> call(FurnitureEntity furniture) {
    return furnitureRepository.favorite(furniture);
  }
}