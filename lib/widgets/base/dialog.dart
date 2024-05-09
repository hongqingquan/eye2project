import 'package:flutter/material.dart';

import 'button.dart';

class BKDialog extends StatelessWidget {
  const BKDialog({
    super.key,
    this.text = "确定",
    this.secondaryText = "取消",
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.hasSecondary = true,
    this.isTextColorPrimary = false,
    required this.child,
  });

  final String text;
  final String secondaryText;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final bool hasSecondary;
  final bool isTextColorPrimary;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: theme.colorScheme.primaryContainer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              Container(
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xffF1F2F2), width: 1))),
                child: Row(
                  children: [
                    if (hasSecondary)
                      Expanded(
                        child: BKButton.filled(
                          height: 70,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.onPrimaryContainer,
                          textStyle: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                          feedback: false,
                          onPressed: onSecondaryTap ??
                              () {
                                _onDismiss(context);
                              },
                          child: Text(
                            secondaryText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    if (hasSecondary)
                      Container(
                        width: 1,
                        height: 70,
                        color: const Color(0xffF1F2F2),
                      ),
                    Expanded(
                      child: BKButton.filled(
                        height: 70,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        foregroundColor: isTextColorPrimary
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onPrimaryContainer,
                        textStyle: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),
                        feedback: false,
                        onPressed: onPrimaryTap ??
                            () {
                              _onDismiss(context);
                            },
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
