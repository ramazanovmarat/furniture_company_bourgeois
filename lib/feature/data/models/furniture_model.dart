import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/furniture_entity.dart';

class FurnitureModel extends FurnitureEntity {
  const FurnitureModel({
      required uid,
      required image,
      required name,
      required description,
      required price,
  }) : super(
    uid: uid,
    image: image,
    name: name,
    description: description,
    price: price,
  );

  factory FurnitureModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return FurnitureModel(
      uid: snapshot['uid'],
      image: snapshot['image'],
      name: snapshot['name'],
      description: snapshot['description'],
      price: snapshot['price'],
    );
  }

  Map<String, dynamic> toJson() => {
    "uid" : uid,
    "image" : image,
    "name" : name,
    "description" : description,
    "price" : price,
  };
}