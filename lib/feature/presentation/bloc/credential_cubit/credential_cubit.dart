import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/entities/user_entity.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/sign_in_user.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/sign_up_user.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/credential_cubit/credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUseCase signInUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;

  CredentialCubit({required this.signInUserUseCase, required this.signUpUserUseCase}) : super(CredentialInitial());

  Future<void> signInUser({required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      await signInUserUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch(_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch(_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}