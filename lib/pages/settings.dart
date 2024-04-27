import 'package:flutter/material.dart';
import 'package:flutter_eye_2_project/pages/change_safe_code.dart';
import 'package:flutter_eye_2_project/widgets/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '波克眼位采集系统',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _Item(title: '充值', isFill: true, onTap: () => _onTopUp(context)),
            _Item(title: '修改安全密码', onTap: () => _onChangeSafeCode(context)),
            _Item(title: '注销', onTap: () => _onCancelAccount(context)),
            _Item(title: '退出登录', onTap: () => _onLogout(context)),
          ],
        ),
      ),
    );
  }

  void _onTopUp(BuildContext context) {
    // TODO 充值
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
