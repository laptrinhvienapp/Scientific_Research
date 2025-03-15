import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: Center(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  final size = constraints.maxWidth * 0.2;

                  return SizedBox(
                    width: size,
                    height: size,
                    child: LiquidCircularProgressIndicator(
                      value: 0.5,
                      valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                      backgroundColor: Colors.white,
                      borderColor: Colors.blue,
                      borderWidth: 1,
                      direction: Axis.vertical,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
