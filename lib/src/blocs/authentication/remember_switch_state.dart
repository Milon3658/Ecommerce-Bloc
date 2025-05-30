part of 'remember_switch_cubit.dart';

@immutable
sealed class RememberSwitchState {}

final class RememberSwitchInitial extends RememberSwitchState {}

final class RememberSwitchChanged extends RememberSwitchState {
  final bool value;

  RememberSwitchChanged(this.value);
}
