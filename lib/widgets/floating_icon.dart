import 'package:flutter/material.dart';

class FloatingIcon extends StatelessWidget {
  const FloatingIcon({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      foregroundColor: Colors.blue,
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: child,
    );
  }
}