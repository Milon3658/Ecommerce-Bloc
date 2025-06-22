import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/repository/repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<RequestGoogleLogin>((event, emit) async {
      try {
        emit(loginLoading());
        final user = await authRepository.signInWithGoogle();
        debugPrint('user : ${user?.displayName.toString()}');
        emit(loginSuccess());
      } catch (error) {
        emit(loginFailed(error.toString()));
      }
    });

    on<RequestFacebookLogin>((event, emit) {
      emit(facebookLoginSuccess());
    });
    on<RequestTwitterLogin>((event, emit) {
      emit(twitterLoginSuccess());
    });

    on<RequestLoginWithEmail>((event, emit) async {
      emit(loginLoading());
      try {
        await authRepository.SignInWithEmail(event.email, event.password)
            .then((value) => emit(loginSuccess()));
      } catch (e) {
        emit(LoginInitial());
        emit(loginFailed(e.toString()));
      }
    });

    on<RequestSignOut>((event, emit) async {
      emit(SignOutLoading());
      try {
        await authRepository.signOut().then((value) => emit(SignOutSuccess()));
      } catch (e) {
        emit(SignOutFailed(message: e.toString()));
      }
    });
  }
}
