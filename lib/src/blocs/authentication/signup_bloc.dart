import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/repository/repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository repository;

  SignupBloc(this.repository) : super(SignupInitial()) {
    on<RequestEmailSIgnUp>((event, emit) async {
      try {
        emit(SignupLoading());
        final data = await repository.signUpWithEmail(
            userName: event.userName,
            email: event.email,
            password: event.password);
        if (data != null) {
          emit(SignupSuccess());
        } else {
          emit(SignupFailed(message: 'Something went wrong'));
        }
      } catch (e) {
        emit(SignupFailed(message: e.toString()));
      }
    });
  }
}
