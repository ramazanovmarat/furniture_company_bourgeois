import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class GetCurrentUidUseCase {
  final FurnitureRepository furnitureRepository;

  GetCurrentUidUseCase({required this.furnitureRepository});

  Future<String> call() {
    return furnitureRepository.getCurrentUid();
  }
}