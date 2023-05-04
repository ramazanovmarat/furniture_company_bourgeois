import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class GetSingleUserUseCase {
  final FurnitureRepository furnitureRepository;

  GetSingleUserUseCase({required this.furnitureRepository});

  Stream<List<UserEntity>> call(String uid) {
    return furnitureRepository.getSingleUser(uid);
  }
}