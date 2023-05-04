import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/get_single_user.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/update_user.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/get_single_user_cubit/get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  GetSingleUserCubit({required this.updateUserUseCase, required this.getSingleUserUseCase}) : super(GetSingleUserInitial());

  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());
    try {
      final streamResponse = getSingleUserUseCase.call(uid);
      streamResponse.listen((users) {
        emit(GetSingleUserLoaded(user: users.first));
      });
    } on SocketException catch(_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }

  Future<void> updateUser({required UserEntity userEntity}) async {
    try {
      await updateUserUseCase.call(userEntity);
    } on SocketException catch(_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }

}