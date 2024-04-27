import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetSafeCodeWidget extends StatefulWidget {

  final VoidCallback onTap;

  const SetSafeCodeWidget({super.key, required this.onTap});

  @override
  State<SetSafeCodeWidget> createState() => _SetSafeCodeWidgetState();
}

class _SetSafeCodeWidgetState extends State<SetSafeCodeWidget> {

  final _codeController = TextEditingController();

  final _confirmCodeController = TextEditingController();

  bool get isCodeComplete => _codeController.text.length == 6;

  bool get isConfirmCodeComplete => _confirmCodeController.text.length == 6;

  bool get isSame => _codeController.text == _confirmCodeController.text;

  bool obscureCode = true;

  bool obscureConfirmCode = true;

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
            border:
            Border.all(color: const Color(0xFFE8E8E8), width: 1),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/position_icon_img_4.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  maxLength: 6,
                  maxLines: 1,
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  obscureText: obscureCode,
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
                    hintText: '设置6位安全密码',
                    hintStyle: TextStyle(
                      color: Color(0xFFCECECE),
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              _codeController.text.isNotEmpty
                  ? InkWell(
                onTap: () =>
                    setState(() => obscureCode = !obscureCode),
                child: Image.asset(
                  'assets/images/position_icon_${obscureCode ? 'invisible' : 'visible'}.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              )
                  : const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color(0xFFE8E8E8), width: 1),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/position_icon_img_3.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  maxLength: 6,
                  maxLines: 1,
                  controller: _confirmCodeController,
                  obscureText: obscureConfirmCode,
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
              const SizedBox(
                width: 12,
              ),
              _confirmCodeController.text.isNotEmpty
                  ? InkWell(
                onTap: () => setState(() =>
                obscureConfirmCode =
                !obscureConfirmCode),
                child: Image.asset(
                  'assets/images/position_icon_${obscureCode ? 'invisible' : 'visible'}.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              )
                  : const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 48,
        ),
        InkWell(
          onTap: () {
            if (!isCodeComplete || !isConfirmCodeComplete) {
              return;
            }
            widget.onTap();
          },
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF002846).withOpacity(
                  isCodeComplete && isConfirmCodeComplete ? 1 : 0.2),
            ),
            alignment: Alignment.center,
            child: const Text('确定',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1,
                )),
          ),
        ),
      ]
    );
  }
}
