import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswordCubit extends Cubit<bool> {
  ConfirmPasswordCubit() : super(true);

  void toggleConfirmPasswordVisibility() {
    emit(!state);
  }
}