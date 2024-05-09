import 'package:flutter/material.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('修改安全密码',),
        leadingWidth: 60,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/position_icon_back.png',
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
