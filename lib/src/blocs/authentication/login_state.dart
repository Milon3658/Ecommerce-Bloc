part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  List<Object?> get props => [emailcontroller, passwordcontroller];
}

class loginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class loginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class loginFailed extends LoginState {
  final String message;

  loginFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class facebookLoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class twitterLoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

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
