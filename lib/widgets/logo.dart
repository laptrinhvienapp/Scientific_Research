import 'package:flutter/material.dart';
import 'package:project/utils/utils.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Image.asset(
          AppImages.logo,
          width: constraints.maxHeight * 0.4,
          height: constraints.maxWidth * 0.4,
        );
      },
    );
  }
}