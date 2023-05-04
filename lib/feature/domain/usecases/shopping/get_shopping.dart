import 'package:furniture_company_bourgeois/feature/domain/entities/shopping_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class GetShoppingUseCase {
  final FurnitureRepository furnitureRepository;

  GetShoppingUseCase({required this.furnitureRepository});

  Stream<List<ShoppingEntity>> call() {
    return furnitureRepository.getShopping();
  }
}