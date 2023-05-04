import 'package:equatable/equatable.dart';

class FurnitureEntity extends Equatable {
  final String? uid;
  final String? image;
  final String? name;
  final String? description;
  final num? price;

  const FurnitureEntity({
    this.uid,
    this.image,
    this.name,
    this.description,
    this.price,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    uid,
    image,
    name,
    description,
    price,
  ];
}