import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class SignInUserUseCase {
  final FurnitureRepository furnitureRepository;

  SignInUserUseCase({required this.furnitureRepository});

  Future<void> call(UserEntity user) {
    return furnitureRepository.signInUser(user);
  }
}