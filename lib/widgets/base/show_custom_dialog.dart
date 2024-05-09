import 'package:flutter/material.dart';

Future<T?> showBKDialog<T extends Object?>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return Navigator.of(context).push<T>(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: false,
      fullscreenDialog: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AnimatedDialogWidget(
          animation: animation,
          barrierDismissible: barrierDismissible,
          child: builder(context),
        );
      },
    ),
  );
}

class AnimatedDialogWidget extends StatelessWidget {
  const AnimatedDialogWidget({
    super.key,
    required this.animation,
    this.barrierDismissible = true,
    this.onTap,
    required this.child,
  });

  final Animation<double> animation;
  final bool barrierDismissible;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        var animValue = animation.value * 6;
        double backgroundOpacity = 0;
        double contentOpacity = 0;
        double contentScale = 0;
        if (animValue <= 1) {
          backgroundOpacity = animValue * 0.2;
          contentOpacity = animValue * 0.5;
          contentScale = 0;
        } else if (animValue <= 2) {
          backgroundOpacity = 0.2 + (animValue - 1) * 0.25;
          contentOpacity = 0.5 + (animValue - 1) * 0.4;
          contentScale = 0.85 + (animValue - 1) * 0.10;
        } else if (animValue <= 3) {
          backgroundOpacity = 0.45 + (animValue - 2) * 0.25;
          contentOpacity = 0.9 + (animValue - 2) * 0.1;
          contentScale = 0.95 + (animValue - 2) * 0.07;
        } else if (animValue <= 4) {
          backgroundOpacity = 0.7;
          contentOpacity = 1.0;
          contentScale = 1.02;
        } else if (animValue <= 5) {
          backgroundOpacity = 0.7;
          contentOpacity = 1.0;
          contentScale = 1.02 - (animValue - 4) * 0.01;
        } else if (animValue <= 6) {
          backgroundOpacity = 0.7;
          contentOpacity = 1.0;
          contentScale = 1.01 - (animValue - 5) * 0.01;
        }
        return GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!.call();
                    return;
                  }
                  if (barrierDismissible) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(backgroundOpacity),
                ),
              ),
              Transform.scale(
                  scale: contentScale,
                  child: Opacity(opacity: contentOpacity, child: child ?? const SizedBox())),
            ],
          ),
        );
      },
      child: child,
    );
  }
}
