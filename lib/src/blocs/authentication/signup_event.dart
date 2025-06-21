part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestEmailSIgnUp extends SignupEvent {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  RequestEmailSIgnUp({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userName, email, password, confirmPassword];
}
