import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class GetAllFurnitureUseCase {
  final FurnitureRepository furnitureRepository;

  GetAllFurnitureUseCase({required this.furnitureRepository});

  Stream<List<FurnitureEntity>> call(FurnitureEntity furniture) {
    return furnitureRepository.getAllFurniture(furniture);
  }
}