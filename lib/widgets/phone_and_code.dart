import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneAndCodeWidget extends StatefulWidget {
  final String buttonName;

  final VoidCallback onTap;

  const PhoneAndCodeWidget(
      {super.key, required this.buttonName, required this.onTap});

  @override
  State<PhoneAndCodeWidget> createState() => _PhoneAndCodeWidgetState();
}

class _PhoneAndCodeWidgetState extends State<PhoneAndCodeWidget> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  bool get isPhoneComplete => _phoneController.text.length == 11;

  bool get isCodeComplete => _codeController.text.length == 4;

  int _countdownSeconds = 60;
  bool _isCountingDown = false;
  Timer? _timer;

  void _startCountdown() {
    if (!_isCountingDown) {
      setState(() {
        _isCountingDown = true;
        _countdownSeconds = 60;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownSeconds > 0) {
            _countdownSeconds--;
          } else {
            _isCountingDown = false;
            _timer?.cancel();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/position_icon_img_6.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  maxLength: 11,
                  maxLines: 1,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onEditingComplete: () {},
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    isDense: true,
                    isCollapsed: true,
                    hintText: '输入手机号',
                    hintStyle: TextStyle(
                      color: Color(0xFFCECECE),
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/position_icon_img_5.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextField(
                        maxLength: 4,
                        maxLines: 1,
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onEditingComplete: () {},
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          isDense: true,
                          isCollapsed: true,
                          hintText: '输入验证码',
                          hintStyle: TextStyle(
                            color: Color(0xFFCECECE),
                            fontSize: 16,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () => _sendCode(context),
              child: Container(
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF002846).withOpacity(
                      isPhoneComplete && !_isCountingDown ? 1 : 0.2),
                ),
                alignment: Alignment.center,
                child: Text(
                  _isCountingDown ? '$_countdownSeconds秒后获取' : '获取验证码',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 48,
        ),
        InkWell(
          onTap: () {
            if (!isPhoneComplete || !isCodeComplete) {
              return;
            }
            widget.onTap();
          },
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF002846)
                  .withOpacity(isPhoneComplete && isCodeComplete ? 1 : 0.2),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.buttonName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _sendCode(BuildContext context) {
    if (!isPhoneComplete || _isCountingDown) {
      return;
    }
    // todo 发送验证码
    _startCountdown();
    setState(() {
      _isCountingDown = true;
    });
  }
}
