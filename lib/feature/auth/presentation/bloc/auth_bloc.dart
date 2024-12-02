// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/cubits/entities/user.dart';
import 'package:blog_app/feature/auth/domain/usecases/current_user.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _appUserCubit = appUserCubit,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_authSignUp);
    on<AuthLogin>(_authLogin);
    on<AuthIsUserLoggedIn>(_authIsUserLoggedIn);
  }

  void _authIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp.authRepository.signUpWithEmailPassword(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _userLogin.authRepository.loginWithEmailPassword(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
