import 'package:furniture_company_bourgeois/feature/domain/entities/cart_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class GetCartUseCase {
  final FurnitureRepository furnitureRepository;

  GetCartUseCase({required this.furnitureRepository});

  Stream<List<CartEntity>> call() {
    return furnitureRepository.getCart();
  }
}