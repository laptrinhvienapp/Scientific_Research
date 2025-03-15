import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:project/config/config.dart';
import 'package:project/utils/utils.dart';
import 'package:project/cubits/welcome_cubit.dart';
import 'package:project/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacings.allMedium,
          child: BlocBuilder<WelcomeCubit, int>(
            builder: (_, currentSlideIndex) {
              final welcomeCubit = context.read<WelcomeCubit>();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CarouselSlider.builder(
                        itemCount: welcomeCubit.imagePaths.length,
                        itemBuilder: (_, index, realIndex) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SvgPicture.asset(
                                  welcomeCubit.imagePaths[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              AppSpacings.heightMedium,
                              Text(
                                welcomeCubit.slideTitleKeys[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              AppSpacings.heightSmall,
                              Text(
                                welcomeCubit.slideDescriptionKeys[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              AppSpacings.heightMedium,
                              DotsIndicator(
                                dotsCount: welcomeCubit.imagePaths.length,
                                position: currentSlideIndex.toDouble(),
                              ),
                            ],
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.5,
                          autoPlay: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            welcomeCubit.updateCurrentSlideIndex(index);
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      LoginButton(
                        text: AppStrings.loginButtonText,
                        onPressed: () => context.go(
                          RoutesLocation.loginScreen,
                        ),
                      ),
                      AppSpacings.heightMedium,
                      CreateAccountButton(
                        text: AppStrings.createAccountButtonText,
                        onPressed: () => context.go(
                          RoutesLocation.createAccountScreen,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}