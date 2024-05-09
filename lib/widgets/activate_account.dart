import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eye_2_project/extenions/theme.dart';

class ActivateAccountWidget extends StatefulWidget {
  final VoidCallback onActivateSuccess;

  const ActivateAccountWidget({super.key, required this.onActivateSuccess});

  @override
  State<ActivateAccountWidget> createState() => _ActivateAccountWidgetState();
}

class _ActivateAccountWidgetState extends State<ActivateAccountWidget> {
  final _codeController = TextEditingController();

  bool get isCodeComplete => _codeController.text.isNotEmpty;

  bool isCodeWrong = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  controller: _codeController,
                  keyboardType: TextInputType.text,
                  style: context.textTheme.titleMedium,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {},
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    isDense: true,
                    isCollapsed: true,
                    hintText: '账号已到期或未激活，请输入激活码',
                    hintStyle: context.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFCECECE),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 48,
          child: isCodeWrong
              ? Container(
                  padding: const EdgeInsets.only(left: 45, top: 12),
                  child: Text(
                    '激活码无效，请检查激活码是否正确',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFFD1813),
                    ),
                  ),
                )
              : null,
        ),
        InkWell(
          onTap: () {
            _activateAccount(context);
          },
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  const Color(0xFF002846).withOpacity(isCodeComplete ? 1 : 0.2),
            ),
            alignment: Alignment.center,
            child: const Text(
              '确定',
              style: TextStyle(
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

  void _activateAccount(BuildContext context) {
    if (!isCodeComplete) {
      return;
    }
    // todo 验证激活码接口
    widget.onActivateSuccess();
  }
}
