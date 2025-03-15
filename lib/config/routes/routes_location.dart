import 'package:flutter/foundation.dart' show immutable;

@immutable
class RoutesLocation {
  const RoutesLocation._();

  static String get welcomeScreen => '/';
  static String get loginScreen => '/loginScreen';
  static String get createAccountScreen => '/createAccountScreen';
  static String get contactsScreen => '/contactsScreen';
}