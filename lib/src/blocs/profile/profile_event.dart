part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {}

class FetchProfileData extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
