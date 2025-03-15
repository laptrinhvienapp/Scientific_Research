import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/config/config.dart';

class WelcomeBackButton extends StatelessWidget {
  const WelcomeBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.go(RoutesLocation.welcomeScreen),
      icon: Icon(
        Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }
}