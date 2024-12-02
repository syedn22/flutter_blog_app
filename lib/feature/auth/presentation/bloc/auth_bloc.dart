// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:blog_app/feature/auth/domain/entities/user.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_authSignUp);
    on<AuthLogin>(_authLogin);
  }

  void _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _userSignUp.authRepository.signUpWithEmailPassword(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _userLogin.authRepository.loginWithEmailPassword(
      email: event.email,
      password: event.password,
    );

    response.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }
}
