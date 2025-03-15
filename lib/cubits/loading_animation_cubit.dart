import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingAnimationCubit extends Cubit<bool> {
  LoadingAnimationCubit() : super(false);

  void showLoading() => emit(true);
  void hideLoading() => emit(false);
}