import 'package:go_router/go_router.dart';
import 'package:project/config/config.dart';
import 'package:project/screens/widgets.dart';

final List<RouteBase> appRoutes = [
  GoRoute(
    path: RoutesLocation.welcomeScreen,
    builder: (_, state) => WelcomeScreen(),
  ),
  GoRoute(
    path: RoutesLocation.loginScreen,
    builder: (_, state) => LoginScreen(),
  ),
  GoRoute(
    path: RoutesLocation.createAccountScreen,
    builder: (_, state) => CreateAccountScreen(),
  ),
  GoRoute(
    path: RoutesLocation.contactsScreen,
    builder: (_, state) => ContactsScreen(),
  ),
];