import 'dart:io';

import 'package:furniture_company_bourgeois/feature/data/datasources/furniture_remote_data_source.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/cart_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/favorite_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/shopping_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';

class FurnitureRepositoryImpl implements FurnitureRepository {
  final FurnitureRemoteDataSource remoteDataSource;

  FurnitureRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<FurnitureEntity>> getAllFurniture(FurnitureEntity furniture) => remoteDataSource.getAllFurnitures(furniture);

  @override
  Future<void> signUpUser(UserEntity user) => remoteDataSource.signUpUsers(user);

  @override
  Future<String> getCurrentUid() => remoteDataSource.getCurrentUids();

  @override
  Future<bool> isSignIn() => remoteDataSource.isSignIns();

  @override
  Future<void> signInUser(UserEntity user) => remoteDataSource.signInUsers(user);

  @override
  Future<void> signOut() => remoteDataSource.signOuts();

  @override
  Future<void> createUser(UserEntity user) => remoteDataSource.createUsers(user);

  @override
  Future<void> updateUser(UserEntity user) => remoteDataSource.updateUsers(user);

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) => remoteDataSource.uploadImageToStorages(file, isPost, childName);

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) => remoteDataSource.getSingleUsers(uid);

  @override
  Stream<List<CartEntity>> getCart() => remoteDataSource.getCarts();

  @override
  Future<void> addCart(FurnitureEntity furniture) => remoteDataSource.addCarts(furniture);

  @override
  Future<void> clearCart() => remoteDataSource.clearCarts();

  @override
  Future<void> clearFavorite() => remoteDataSource.clearFavorites();

  @override
  Future<void> favorite(FurnitureEntity furniture) => remoteDataSource.favorites(furniture);

  @override
  Stream<List<FavoriteEntity>> getFavorite() => remoteDataSource.getFavorites();

  @override
  Future<void> addShopping() => remoteDataSource.addShoppings();

  @override
  Stream<List<ShoppingEntity>> getShopping() => remoteDataSource.getShoppings();
}