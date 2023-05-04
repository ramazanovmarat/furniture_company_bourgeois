import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class UpdateUserUseCase {
  final FurnitureRepository furnitureRepository;

  UpdateUserUseCase({required this.furnitureRepository});

  Future<void> call(UserEntity userEntity) {
    return furnitureRepository.updateUser(userEntity);
  }
}