import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/config/config.dart';
import 'package:project/cubits/cubits.dart';
import 'package:project/services/firebase_services.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseServices.setupFirebase();

  /// 2/5: Đặt khóa navigator thành ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // Gọi useSystemCallingUI
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [
        ZegoUIKitSignalingPlugin()
      ],
    );
  });

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WelcomeCubit(),
        ),
        BlocProvider(
          create: (_) => EmailClearTextCubit(),
        ),
        BlocProvider(
          create: (_) => UserNameClearTextCubit(),
        ),
        BlocProvider(
          create: (_) => PasswordCubit(),
        ),
        BlocProvider(
          create: (_) => ConfirmPasswordCubit(),
        ),
        BlocProvider(
          create: (_) => LoadingAnimationCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
