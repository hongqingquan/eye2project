import 'package:flutter/material.dart';
import 'package:flutter_eye_2_project/pages/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'theme.dart';
import 'toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "波克眼位采集系统",
      theme: BKTheme.normal,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh'),
      ],
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: Toast(
            child: child ?? const SizedBox.expand(),
          ),
        );
      },
      home: const LoginPage(),
    );
  }
}
