import 'package:equatable/equatable.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';

abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();
}

class GetSingleUserInitial extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoading extends GetSingleUserState {
  @override
  List<Object> get props => [];
}


class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity user;

  const GetSingleUserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class GetSingleUserFailure extends GetSingleUserState {
  @override
  List<Object> get props => [];
}