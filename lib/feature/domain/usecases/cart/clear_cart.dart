import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class ClearCartUseCase {
  final FurnitureRepository furnitureRepository;

  ClearCartUseCase({required this.furnitureRepository});

  Future<void> call() {
    return furnitureRepository.clearCart();
  }
}