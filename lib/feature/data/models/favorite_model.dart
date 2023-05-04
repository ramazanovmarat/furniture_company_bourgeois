import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  const FavoriteModel({
    required postID,
    required image,
    required name,
    required description,
    required price,
  }) : super(
    postID: postID,
    image: image,
    name: name,
    description: description,
    price: price,
  );

  factory FavoriteModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return FavoriteModel(
      postID: snapshot['postID'],
      image: snapshot['image'],
      name: snapshot['name'],
      description: snapshot['description'],
      price: snapshot['price'],
    );
  }

  Map<String, dynamic> toJson() => {
    "postID" : postID,
    "image" : image,
    "name" : name,
    "description" : description,
    "price" : price,
  };
}