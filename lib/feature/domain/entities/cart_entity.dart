import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String? postID;
  final String? image;
  final String? name;
  final String? description;
  final num? price;

  const CartEntity({
    this.postID,
    this.image,
    this.name,
    this.description,
    this.price,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    postID,
    image,
    name,
    description,
    price,
  ];
}