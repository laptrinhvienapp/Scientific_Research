import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconCircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconAsset;

  const IconCircleButton({
    super.key,
    required this.onPressed,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconAsset,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}