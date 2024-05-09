import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'theme.dart';

class Toast extends StatelessWidget {
  const Toast({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: const Color(0xFF424242),
      position: const ToastPosition(align: Alignment(0, -0.3)),
      radius: 10,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        inherit: false,
        fontFamily: BKTheme.fontFamily,
        fontFamilyFallback: BKTheme.fontFamilyFallback,
      ),
      dismissOtherOnShow: true,
      textPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      duration: const Duration(seconds: 3),
      child: child,
    );
  }
}
