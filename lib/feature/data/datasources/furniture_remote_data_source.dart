import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_company_bourgeois/feature/data/models/cart_model.dart';
import 'package:furniture_company_bourgeois/feature/data/models/favorite_model.dart';
import 'package:furniture_company_bourgeois/feature/data/models/furniture_model.dart';
import 'package:furniture_company_bourgeois/feature/data/models/shopping_model.dart';
import 'package:furniture_company_bourgeois/feature/data/models/user_model.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/cart_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/shopping_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

abstract class FurnitureRemoteDataSource {

  //Furniture
  Stream<List<FurnitureEntity>> getAllFurnitures(FurnitureEntity furniture);

  //User
  Future<void> signUpUsers(UserEntity user);
  Future<void> signInUsers(UserEntity user);
  Future<bool> isSignIns();
  Future<void> signOuts();
  Future<String> getCurrentUids();
  Future<void> createUsers(UserEntity user);
  Future<void> updateUsers(UserEntity user);
  Future<String> uploadImageToStorages(File? file, bool isPost, String childName);
  Stream<List<UserEntity>> getSingleUsers(String uid);

  //Cart
  Stream<List<CartModel>> getCarts();
  Future<void> addCarts(FurnitureEntity furniture);
  Future<void> clearCarts();
  // Future<bool> isAddCarts();

  //Favorite
  Stream<List<FavoriteModel>> getFavorites();
  Future<void> favorites(FurnitureEntity furniture);
  Future<void> clearFavorites();

  //Shopping
  Stream<List<ShoppingModel>> getShoppings();
  Future<void> addShoppings();

}

class FurnitureRemoteDataSourceImpl implements FurnitureRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  FurnitureRemoteDataSourceImpl({required this.firebaseAuth, required this.firebaseFirestore, required this.firebaseStorage});

  @override
  Stream<List<FurnitureEntity>> getAllFurnitures(FurnitureEntity furniture) {
    final furnitureCollection = firebaseFirestore.collection("furniture");
    print('Furniture: $furnitureCollection');
    return furnitureCollection.snapshots().map((querySnapshot) =>
    querySnapshot.docs.map((e) => FurnitureModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> signUpUsers(UserEntity user) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: user.email!, password: user.password!).then((currentUser) async {
        if (currentUser.user?.uid != null) {
          if (user.imageUrl != null) {
            uploadImageToStorages(user.imageUrl, false, "profileImages").then((profileUrl) {
              createUserWithImage(user, profileUrl);
            });
          } else {
            createUserWithImage(user, "");
          }
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      Future.error('error: $e');
    }
  }

  // Future<void> verifyEmail() async {
  //   User? user = firebaseAuth.currentUser;
  //   if(user != null && !user.emailVerified) {
  //     return await user.sendEmailVerification();
  //   }
  // }

  @override
  Future<String> getCurrentUids() async => firebaseAuth.currentUser!.uid;

  @override
  Future<bool> isSignIns() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUsers(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      } else {
        print("fields cannot be empty");
      }
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  @override
  Future<void> signOuts() async => firebaseAuth.signOut();

  Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
    final userCollection = firebaseFirestore.collection("users");
    final uid = await getCurrentUids();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        profileUrl: profileUrl,
        email: user.email,
      ).toJson();
      if(!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      print('error');
    });
  }

  @override
  Future<String> uploadImageToStorages(File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);
    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Future<void> updateUsers(UserEntity user) async {
    final userCollection = firebaseFirestore.collection("users");
    Map<String, dynamic> userInformation = Map();

    if (user.name != "" && user.name != null) userInformation['name'] = user.name;
    if (user.profileUrl != "" && user.profileUrl != null) userInformation['profileUrl'] = user.profileUrl;

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<void> createUsers(UserEntity user) async {
    final userCollection = firebaseFirestore.collection("users");

    final uid = await getCurrentUids();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
          profileUrl: user.profileUrl,
          uid: uid,
          name: user.name,
          email: user.email,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      print("Error");
    });
  }

  @override
  Stream<List<UserEntity>> getSingleUsers(String uid) {
    final userCollection = firebaseFirestore.collection("users").where("uid", isEqualTo: uid).limit(1);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<CartModel>> getCarts() {
    final cartCollection = firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart");
    return cartCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => CartModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> addCarts(FurnitureEntity furniture) async {
    firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").add({
      "postID" : furniture.uid,
      "image" : furniture.image,
      "name" : furniture.name,
      "description" : furniture.description,
      "price" : furniture.price,
    });
  }

  @override
  Future<void> clearCarts() async {
    final collection = await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("cart").get();
    final batch = firebaseFirestore.batch();
    for(final doc in collection.docs) {
      batch.delete(doc.reference);
    }
    return batch.commit();
  }

  @override
  Future<void> favorites(FurnitureEntity furniture) async {
    firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("favorite").add({
      "postID" : furniture.uid,
      "image" : furniture.image,
      "name" : furniture.name,
      "description" : furniture.description,
      "price" : furniture.price,
    });
  }

  @override
  Future<void> clearFavorites() async {
    final collection = await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("favorite").get();
    final batch = firebaseFirestore.batch();
    for(final doc in collection.docs) {
      batch.delete(doc.reference);
    }
    return batch.commit();
  }

  @override
  Stream<List<FavoriteModel>> getFavorites() {
    final cartCollection = firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("favorite");
    return cartCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => FavoriteModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> addShoppings() async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart").get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("shopping").add({
        "postID" : doc['postID'],
        "image" : doc['image'],
        "name" : doc['name'],
        "description" : doc['description'],
        "price" : doc['price'],
      });
    }
  }

  @override
  Stream<List<ShoppingModel>> getShoppings() {
    final shoppingCollection = firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).collection("shopping");
    return shoppingCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => ShoppingModel.fromSnapshot(e)).toList());
  }
}

