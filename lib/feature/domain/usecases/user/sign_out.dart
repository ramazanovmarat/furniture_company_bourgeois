import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class SignOutUseCase {
  final FurnitureRepository furnitureRepository;

  SignOutUseCase({required this.furnitureRepository});

  Future<void> call() {
    return furnitureRepository.signOut();
  }
}