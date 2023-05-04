import 'dart:io';

import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class UploadImageToStorageUseCase {
  final FurnitureRepository furnitureRepository;

  UploadImageToStorageUseCase({required this.furnitureRepository});

  Future<String> call(File file, bool isPost, String childName) {
    return furnitureRepository.uploadImageToStorage(file, isPost, childName);
  }
}