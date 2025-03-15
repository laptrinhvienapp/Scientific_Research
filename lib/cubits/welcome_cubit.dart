import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/utils/utils.dart';

class WelcomeCubit extends Cubit<int> {
  WelcomeCubit() : super(0);

  final List<String> imagePaths = [
    AppIcons.welcome1,
    AppIcons.welcome2,
    AppIcons.welcome3,
  ];

  final List<String> slideTitleKeys = [
    AppStrings.slide1Title,
    AppStrings.slide2Title,
    AppStrings.slide3Title,
  ];

  final List<String> slideDescriptionKeys = [
    AppStrings.slide1Description,
    AppStrings.slide2Description,
    AppStrings.slide3Description,
  ];

  void updateCurrentSlideIndex(int index) {
    emit(index);
  }
}