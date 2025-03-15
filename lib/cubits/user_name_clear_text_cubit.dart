import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameClearTextCubit extends Cubit<bool> {
  UserNameClearTextCubit() : super(false);

  void clearText(TextEditingController controller) {
    controller.clear();
    emit(false);
  }

  void updateClearText(String text) {
    emit(text.isNotEmpty);
  }
}