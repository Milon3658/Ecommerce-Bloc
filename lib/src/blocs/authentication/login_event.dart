part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class RequestGoogleLogin extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class RequestFacebookLogin extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class RequestTwitterLogin extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class RequestLoginWithEmail extends LoginEvent {
  final String email;
  final String password;

  RequestLoginWithEmail({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class RequestSignOut extends LoginEvent {
  @override
  List<Object?> get props => [];
}
