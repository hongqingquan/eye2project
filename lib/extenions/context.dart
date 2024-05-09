import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);
}
