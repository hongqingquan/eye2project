import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eye_2_project/extenions/theme.dart';
import 'package:flutter_eye_2_project/pages/change_safe_code.dart';
import 'package:flutter_eye_2_project/widgets/base/dialog.dart';
import 'package:flutter_eye_2_project/widgets/base/show_custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final bool isAccountExpired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          '波克眼位采集系统',
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),
            isAccountExpired
                ? _TopUpExpired(
                    onTap: () => _showTopUpDialog(context),
                  )
                : _TopUpNotExpired(
                    onTap: () => _showTopUpDialog(context),
                  ),
            _Item(title: '修改安全密码', onTap: () => _onChangeSafeCode(context)),
            _Item(title: '注销', onTap: () => _onCancelAccount(context)),
            _Item(title: '退出登录', onTap: () => _onLogout(context)),
          ],
        ),
      ),
    );
  }

  void _showTopUpDialog(BuildContext context) {
    showBKDialog(
        context: context,
        builder: (context) {
          return const _TopUpDialog();
        });
  }

  void _onChangeSafeCode(BuildContext context) {
    // TODO 修改安全密码
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ChangeSafeCodePage()));
  }

  void _onCancelAccount(BuildContext context) {
    // TODO 注销
  }

  void _onLogout(BuildContext context) {
    // TODO 退出登录
  }
}

class _Item extends StatelessWidget {
  _Item({super.key, required this.title, this.isFill = false, this.onTap});

  String title;

  bool isFill;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isFill
                ? null
                : Border.all(color: const Color(0xFFE8E8E8), width: 1),
            color: isFill ? const Color(0xFF0099C2) : Colors.white,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isFill ? Colors.white : const Color(0xFF002846),
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _TopUpExpired extends StatelessWidget {
  const _TopUpExpired({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
          color: context.colorScheme.background,
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                '2024.5.5到期',
                style: context.textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFFD1813),
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.colorScheme.primary,
                ),
                alignment: Alignment.center,
                child: Text(
                  '立即续期',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopUpNotExpired extends StatelessWidget {
  const _TopUpNotExpired({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
          color: context.colorScheme.background,
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '用户尾号（2568）',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text.rich(
                    TextSpan(
                      style: context.textTheme.titleSmall,
                      children: [
                        TextSpan(
                          text: '2024.08.25',
                          style: TextStyle(
                            fontSize: 13,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        const TextSpan(
                          text: '到期',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 97,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: context.colorScheme.secondary,
                ),
                alignment: Alignment.center,
                child: Text(
                  '立即续期',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopUpDialog extends StatefulWidget {
  const _TopUpDialog({super.key});

  @override
  State<_TopUpDialog> createState() => _TopUpDialogState();
}

class _TopUpDialogState extends State<_TopUpDialog> {
  final _codeController = TextEditingController();

  bool isCodeWrong = false;

  @override
  Widget build(BuildContext context) {
    return BKDialog(
      isTextColorPrimary: true,
      text: '确认',
      onPrimaryTap: () {
        _topUp();
        Navigator.of(context).pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            '用户尾号（2568）',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 208,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/position_icon_img_11.png',
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
                      hintText: '输入激活码',
                      hintStyle: context.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFCECECE),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(
              style: context.textTheme.titleSmall,
              children: [
                TextSpan(
                  text: '2024.08.25',
                  style: TextStyle(
                    fontSize: 13,
                    color: context.colorScheme.primary,
                  ),
                ),
                const TextSpan(
                  text: '到期，激活后顺延有效期',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 44,
            child: isCodeWrong
                ? Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '激活码无效，请检查激活码是否正确',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFFD1813),
                        fontSize: 12,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  void _topUp() {
    // todo 续费
  }
}
