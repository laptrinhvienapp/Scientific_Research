import 'package:flutter/material.dart';
import 'package:project/widgets/widgets.dart';
import 'package:project/utils/utils.dart';

class LoginMethods extends StatelessWidget {
  const LoginMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconCircleButton(
          onPressed: () {},
          iconAsset: AppIcons.googleLogo,
        ),
        AppSpacings.widthLarge,
        IconCircleButton(
          onPressed: () {},
          iconAsset: AppIcons.appleLogo,
        )
      ],
    );
  }
}
