import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class IsSignInUseCase {
  final FurnitureRepository furnitureRepository;

  IsSignInUseCase({required this.furnitureRepository});

  Future<bool> call() {
    return furnitureRepository.isSignIn();
  }
}