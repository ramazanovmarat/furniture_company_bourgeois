import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class SignUpUserUseCase {
  final FurnitureRepository furnitureRepository;

  SignUpUserUseCase({required this.furnitureRepository});

  Future<void> call(UserEntity user) {
    return furnitureRepository.signUpUser(user);
  }
}