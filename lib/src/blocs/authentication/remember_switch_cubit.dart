import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'remember_switch_state.dart';

class RememberSwitchCubit extends Cubit<RememberSwitchState> {
  RememberSwitchCubit() : super(RememberSwitchInitial());

  static bool isRemember = true;

  void toggleSwitch(bool value) {
    isRemember = value;
    emit(RememberSwitchChanged(value));
  }
}
