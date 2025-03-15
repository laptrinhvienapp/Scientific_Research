import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:project/config/config.dart';

/// 1/5: Định nghĩa khóa điều hướng (navigator key)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  routes: appRoutes,
  /// 3/5: Đăng ký khóa điều hướng vào MaterialApp
  navigatorKey: navigatorKey,
);