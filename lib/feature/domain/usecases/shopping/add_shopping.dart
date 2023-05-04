import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class AddShoppingUseCase {
  final FurnitureRepository furnitureRepository;

  AddShoppingUseCase({required this.furnitureRepository});

  Future<void> call() {
    return furnitureRepository.addShopping();
  }
}