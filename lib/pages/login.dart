import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eye_2_project/extenions/theme.dart';
import 'package:flutter_eye_2_project/pages/home.dart';
import 'package:flutter_eye_2_project/widgets/activate_account.dart';
import 'package:flutter_eye_2_project/widgets/phone_and_code.dart';
import 'package:flutter_eye_2_project/widgets/set_safe_code.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  var isNewUser = true;

  var accountNotActivated = true;

  int showIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '欢迎登录',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    '波克眼位采集系统',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 342,
                    child: Column(
                      children: [
                        IndexedStack(
                          index: showIndex,
                          children: [
                            PhoneAndCodeWidget(
                              buttonName: '登录',
                              onTap: () => _login(context),
                            ),
                            SetSafeCodeWidget(
                                onTap: () => _onSetSafeCode(context)),
                            ActivateAccountWidget(
                                onActivateSuccess: () =>
                                    _onActivateSuccess(context)),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (isNewUser) {
      setState(() {
        showIndex = 1;
      });
      return;
    }
    if (accountNotActivated) {
      setState(() {
        showIndex = 2;
      });
      return;
    }
    // todo 调用登录接口
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _onSetSafeCode(BuildContext context) {
    if (accountNotActivated) {
      setState(() {
        showIndex = 2;
      });
      return;
    }
    // todo 设置安全密码接口
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _onActivateSuccess(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
