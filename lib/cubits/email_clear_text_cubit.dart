import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailClearTextCubit extends Cubit<bool> {
  EmailClearTextCubit() : super(false);

  void clearText(TextEditingController controller) {
    controller.clear();
    emit(false);
  }

  void updateClearText(String text) {
    emit(text.isNotEmpty);
  }
}
