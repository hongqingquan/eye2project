import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eye_2_project/pages/home.dart';
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

  var crossFadeState = CrossFadeState.showFirst;

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
                  const Text(
                    '欢迎登录',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF002846),
                      height: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text('波克眼位采集系统',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF002846),
                        height: 1,
                      )),
                  const SizedBox(
                    height: 60,
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: crossFadeState,
                    firstChild: PhoneAndCodeWidget(
                      buttonName: '登录',
                      onTap: () => _login(context),
                    ),
                    secondChild:
                        SetSafeCodeWidget(onTap: () => _onSetSafeCode(context)),
                  ),
                  const SizedBox(
                    height: 150,
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
    // todo 登录
    if (isNewUser) {
      setState(() {
        crossFadeState = CrossFadeState.showSecond;
      });
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  void _onSetSafeCode(BuildContext context) {
    // todo 设置安全密码
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
