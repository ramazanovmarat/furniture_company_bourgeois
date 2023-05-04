import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required profileUrl,
    required uid,
    required name,
    required email,
  }) : super(
    profileUrl: profileUrl,
    uid: uid,
    name: name,
    email: email,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        profileUrl: snapshot.get('profileUrl'),
        uid: snapshot.get('uid'),
        name: snapshot.get('name'),
        email: snapshot.get('email'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profileUrl": profileUrl,
      "uid": uid,
      "name": name,
      "email": email,
    };
  }
}