import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eye_2_project/pages/home.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/phone_and_code.dart';
import '../widgets/set_safe_code.dart';

class ChangeSafeCodePage extends StatefulWidget {
  const ChangeSafeCodePage({super.key});

  @override
  State<ChangeSafeCodePage> createState() => _ChangeSafeCodePageState();
}

class _ChangeSafeCodePageState extends State<ChangeSafeCodePage> {

  var crossFadeState = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '修改安全密码',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: crossFadeState,
            firstChild: PhoneAndCodeWidget(
              buttonName: '确定修改',
              onTap: () {
                setState(() {
                  crossFadeState = CrossFadeState.showSecond;
                });
              },
            ),
            secondChild:
            SetSafeCodeWidget(onTap: () => _onChangeSafeCode(context)),
          ),
        ),
      ),
    );
  }

  void _onChangeSafeCode(BuildContext context) {
    // todo 修改安全密码
    Navigator.of(context).pop();
  }
}
