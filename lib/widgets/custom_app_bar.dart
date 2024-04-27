import 'package:flutter/material.dart';

typedef CustomAppBarOnPop = void Function(BuildContext context);

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? right;

  const CustomAppBar({
    super.key,
    required this.title,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 48,
      leadingWidth: 40,
      title: Text(title,
          style: const TextStyle(
              color: Color(0xFF002846),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1)),
      leading: _buildBackButton(context),
      actions: [right ?? const SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);

  Widget _buildBackButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(
          'assets/images/position_icon_back.png',
          width: 20,
          height: 20,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
