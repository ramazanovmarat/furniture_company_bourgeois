import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class ClearFavoriteUseCase {
  final FurnitureRepository furnitureRepository;

  ClearFavoriteUseCase({required this.furnitureRepository});

  Future<void> call() {
    return furnitureRepository.clearFavorite();
  }
}