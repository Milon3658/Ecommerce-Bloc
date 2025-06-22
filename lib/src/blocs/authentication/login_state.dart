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

class facebookLoginSuccess extends LoginState {}

class twitterLoginSuccess extends LoginState {}

class SignOutLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class SignOutSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class SignOutFailed extends LoginState {
  final String message;

  SignOutFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
