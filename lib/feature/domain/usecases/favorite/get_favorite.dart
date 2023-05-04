import 'package:furniture_company_bourgeois/feature/domain/entities/favorite_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class GetFavoriteUseCase {
  final FurnitureRepository furnitureRepository;

  GetFavoriteUseCase({required this.furnitureRepository});

  Stream<List<FavoriteEntity>> call() {
    return furnitureRepository.getFavorite();
  }
}