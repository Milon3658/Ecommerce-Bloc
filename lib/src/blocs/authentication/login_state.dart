part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class loginLoading extends LoginState {}

class loginSuccess extends LoginState {}

class loginFailed extends LoginState {
  final String message;

  loginFailed(this.message);
}
