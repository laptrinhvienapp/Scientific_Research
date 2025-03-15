import 'package:flutter/material.dart';

class AppSpacings {
  const AppSpacings._();

  static final EdgeInsets allSmall = EdgeInsets.all(8);
  static final EdgeInsets allMedium = EdgeInsets.all(16);
  static final EdgeInsets horizontalSmall = EdgeInsets.symmetric(horizontal: 8);
  static final EdgeInsets verticalMedium = EdgeInsets.symmetric(vertical: 16);
  static final SizedBox heightSmall = SizedBox(height: 8.0);
  static final SizedBox heightMedium = SizedBox(height: 16.0);
  static final SizedBox heightLarge = SizedBox(height: 24.0);
  static final SizedBox heightExtraLarge = SizedBox(height: 32.0);
  static final SizedBox widthLarge = SizedBox(width: 24.0);
  static final SizedBox widthMedium = SizedBox(width: 16.0);
}