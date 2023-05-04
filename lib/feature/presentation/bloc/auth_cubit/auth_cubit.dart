import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/get_current_uid.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/is_sign_in.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/sign_out.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  AuthCubit({required this.signOutUseCase, required this.isSignInUseCase, required this.getCurrentUidUseCase}) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn == true) {

        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch(_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } catch(_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}