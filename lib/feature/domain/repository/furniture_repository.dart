
import 'dart:io';

import 'package:furniture_company_bourgeois/feature/domain/entities/cart_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/favorite_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/shopping_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';

abstract class FurnitureRepository {

  //Furniture
  Stream<List<FurnitureEntity>> getAllFurniture(FurnitureEntity furniture);

  //User
  Future<void> signUpUser(UserEntity user);
  Future<void> signInUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Future<void> updateUser(UserEntity user);
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName);

  //Cart
  Future<void> addCart(FurnitureEntity furniture);
  Stream<List<CartEntity>> getCart();
  Future<void> clearCart();

  //Favorite
  Future<void> favorite(FurnitureEntity furniture);
  Stream<List<FavoriteEntity>> getFavorite();
  Future<void> clearFavorite();

  //Shopping
  Future<void> addShopping();
  Stream<List<ShoppingEntity>> getShopping();
}