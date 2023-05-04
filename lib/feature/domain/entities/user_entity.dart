import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? profileUrl;
  final String? password;
  final File? imageUrl;

  const UserEntity({
    this.imageUrl,
    this.profileUrl,
    this.uid,
    this.name,
    this.email,
    this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    imageUrl,
    profileUrl,
    uid,
    name,
    email,
    password,
  ];
}