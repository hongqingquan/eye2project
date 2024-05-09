import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BKButton extends StatefulWidget {
  const BKButton({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    required this.style,
    required this.onPressed,
    this.disable,
    required this.child,
    this.feedback,
  });

  BKButton.text({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    ThemeData? theme,
    Color? foregroundColor,
    Color? backgroundColor,
    TextStyle? textStyle,
    InteractiveInkFeatureFactory? splashFactory,
    BorderRadiusGeometry? borderRadius,
    required this.onPressed,
    this.disable,
    required this.child,
    this.feedback,
  }) : style = BKOutlinedButtonStyle(
          foregroundColor: foregroundColor ?? theme?.colorScheme.primary,
          textStyle: textStyle ?? theme?.textTheme.titleMedium,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        );

  BKButton.filled({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    ThemeData? theme,
    Color? foregroundColor,
    Color? backgroundColor,
    TextStyle? textStyle,
    InteractiveInkFeatureFactory? splashFactory,
    BorderRadiusGeometry? borderRadius,
    required this.onPressed,
    this.disable,
    required this.child,
    this.feedback,
  }) : style = BKFilledButtonStyle(
          foregroundColor: foregroundColor ?? theme?.colorScheme.onPrimary,
          backgroundColor: backgroundColor ?? theme?.colorScheme.primary,
          textStyle: textStyle ?? theme?.textTheme.titleMedium,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        );

  BKButton.outlined({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    ThemeData? theme,
    Color? foregroundColor,
    TextStyle? textStyle,
    InteractiveInkFeatureFactory? splashFactory,
    BorderRadiusGeometry? borderRadius,
    BorderSide? side,
    required this.onPressed,
    this.disable,
    required this.child,
    this.feedback,
  }) : style = BKOutlinedButtonStyle(
          foregroundColor: foregroundColor ?? theme?.colorScheme.primary ?? Colors.black,
          textStyle: textStyle ?? theme?.textTheme.titleMedium,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          side: side ?? const BorderSide(),
        );

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BKBaseButtonStyle style;
  final VoidCallback? onPressed;
  final bool? disable;

  /// default has vibrate haptic feedback.
  final bool? feedback;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _BKButtonState();
}

class _BKButtonState extends State<BKButton> {
  late MaterialStatesController _controller;
  @override
  void initState() {
    super.initState();
    _controller = MaterialStatesController();
    _controller.addListener(handleStatesControllerChange);
  }

  @override
  void dispose() {
    _controller.removeListener(handleStatesControllerChange);
    _controller.dispose();
    super.dispose();
  }

  void handleStatesControllerChange() {
    if (widget.feedback == false) {
      return;
    }
    final value = _controller.value;
    if (value.contains(MaterialState.pressed)) {
      HapticFeedback.selectionClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.style;
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    style = BKBaseButtonStyle(
      textStyle: defaultTextStyle,
    ).merge(style);
    Widget child = widget.child;

    final padding = widget.padding;
    if (padding != null) {
      child = Padding(padding: padding, child: child);
    }
    child = SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        statesController: _controller,
        style: style._buttonStyle,
        onPressed: (widget.disable ?? false) ? null : widget.onPressed,
        child: child,
      ),
    );
    final margin = widget.margin;
    if (margin != null) {
      child = Padding(padding: margin, child: child);
    }
    return child;
  }
}

class BKFilledButtonStyle extends BKBaseButtonStyle {
  BKFilledButtonStyle({
    super.foregroundColor,
    super.backgroundColor,
    super.textStyle,
    super.splashFactory,
    super.borderRadius,
  }) : super();

  BKFilledButtonStyle.theme({
    required ThemeData theme,
    Color? foregroundColor,
    Color? backgroundColor,
    TextStyle? textStyle,
    InteractiveInkFeatureFactory? splashFactory,
    BorderRadiusGeometry? borderRadius,
  }) : super(
          foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          textStyle: textStyle ?? theme.textTheme.titleMedium,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        );
}

class BKOutlinedButtonStyle extends BKBaseButtonStyle {
  BKOutlinedButtonStyle({
    super.foregroundColor,
    super.textStyle,
    super.splashFactory,
    super.borderRadius,
    super.side = const BorderSide(),
  }) : super();

  BKOutlinedButtonStyle.theme({
    required ThemeData theme,
    Color? foregroundColor,
    TextStyle? textStyle,
    InteractiveInkFeatureFactory? splashFactory,
    BorderRadiusGeometry? borderRadius,
  }) : super(
          foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
          textStyle: textStyle ?? theme.textTheme.titleMedium,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        );
}

class BKBaseButtonStyle {
  BKBaseButtonStyle({
    this.foregroundColor,
    this.backgroundColor,
    this.textStyle,
    this.splashFactory,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.side,
  });

  final InteractiveInkFeatureFactory? splashFactory;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? side;
  final TextStyle? textStyle;
  final Color? foregroundColor;
  final Color? backgroundColor;

  ButtonStyle get _buttonStyle => _ButtonStyle(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        textStyle: textStyle,
        borderRadius: borderRadius,
        side: side,
        splashFactory: splashFactory,
        alignment: Alignment.center,
      );

  BKBaseButtonStyle merge(BKBaseButtonStyle? style) {
    if (style == null) {
      return this;
    }
    return BKBaseButtonStyle(
      foregroundColor: style.foregroundColor ?? foregroundColor,
      backgroundColor: style.backgroundColor ?? backgroundColor,
      textStyle: textStyle?.merge(style.textStyle) ?? style.textStyle,
      splashFactory: style.splashFactory ?? splashFactory,
      borderRadius: style.borderRadius ?? borderRadius,
      side: style.side ?? side,
    );
  }
}

class _ButtonStyle extends ButtonStyle {
  _ButtonStyle({
    Color? foregroundColor,
    Color? backgroundColor,
    TextStyle? textStyle,
    BorderRadiusGeometry? borderRadius,
    BorderSide? side,
    super.alignment,
    super.splashFactory,
  })  : _foregroundColor = _removeColorAlpha(foregroundColor),
        _backgroundColor = _removeColorAlpha(backgroundColor),
        _borderRadius = borderRadius,
        _side = side,
        _textStyle = textStyle;

  final BorderRadiusGeometry? _borderRadius;
  final BorderSide? _side;
  final TextStyle? _textStyle;
  final Color? _foregroundColor;
  final Color? _backgroundColor;

  static Color? _removeColorAlpha(Color? color) {
    if (color == null || color.opacity == 1) {
      return color;
    }
    return Color.alphaBlend(color, Colors.white);
  }

  @override
  MaterialStateProperty<OutlinedBorder>? get shape {
    final borderRadius = _borderRadius;
    if (borderRadius == null) {
      return null;
    }
    return MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: borderRadius),
    );
  }

  @override
  MaterialStateProperty<BorderSide>? get side {
    final foregroundColor = _foregroundColor;
    final side = _side;
    if (side == null || foregroundColor == null) {
      return null;
    }
    final endColor = foregroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    final disableColor = Color.lerp(foregroundColor, endColor, 0.8);
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return BorderSide(color: disableColor ?? foregroundColor, width: side.width);
      }
      return BorderSide(color: foregroundColor, width: side.width);
    });
  }

  @override
  MaterialStateProperty<TextStyle?>? get textStyle {
    if (_textStyle == null) {
      return null;
    }
    // final textStyle = TextStyle(color: _foregroundColor).merge(_textStyle);
    return MaterialStateProperty.all(_textStyle);
  }

  @override
  MaterialStateProperty<Color?>? get foregroundColor {
    final foregroundColor = _foregroundColor;
    final backgroundColor = _backgroundColor;
    if (foregroundColor == null || foregroundColor == Colors.transparent) {
      return null;
    }
    if (backgroundColor != null && backgroundColor != Colors.transparent) {
      return MaterialStateProperty.all(foregroundColor);
    }
    final endColor = foregroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    final disableColor = Color.alphaBlend(foregroundColor.withOpacity(0.2), endColor);
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return disableColor;
      }
      return foregroundColor;
    });
  }

  @override
  MaterialStateProperty<Color?>? get backgroundColor {
    final backgroundColor = _backgroundColor;
    if (backgroundColor == null || backgroundColor == Colors.transparent) {
      return null;
    }
    final endColor = backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    final disableColor = Color.alphaBlend(backgroundColor.withOpacity(0.2), endColor);
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return disableColor;
      }
      return backgroundColor;
    });
  }

  @override
  MaterialStateProperty<Color?>? get overlayColor {
    final foregroundColor = _foregroundColor;
    final backgroundColor = _backgroundColor;

    if (foregroundColor != null &&
        (backgroundColor == null || backgroundColor == Colors.transparent)) {
      final luminance = foregroundColor.computeLuminance();
      final endColor = luminance > 0.5 ? Colors.black : Colors.white;
      final pressedColor = Color.alphaBlend(
        foregroundColor.withOpacity(0.05 + (0.05 * (1 - luminance))),
        endColor,
      );

      return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return pressedColor;
        }
        return Colors.transparent;
      });
    }
    if (backgroundColor != null) {
      final luminance = backgroundColor.computeLuminance();
      final endColor = luminance > 0.5 ? Colors.black : Colors.white;
      final pressedColor = Color.alphaBlend(
        backgroundColor.withOpacity(0.95 - (0.05 * (1 - luminance))),
        endColor,
      );
      return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return pressedColor;
        }
        return Colors.transparent;
      });
    }
    return null;
  }

  @override
  MaterialStateProperty<Color>? get shadowColor {
    return const MaterialStatePropertyAll<Color>(Colors.transparent);
  }

  @override
  MaterialStateProperty<Color>? get surfaceTintColor {
    return const MaterialStatePropertyAll<Color>(Colors.transparent);
  }

  @override
  MaterialStateProperty<double>? get elevation {
    return const MaterialStatePropertyAll<double>(0);
  }

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding {
    return const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero);
  }

  @override
  MaterialStateProperty<Size>? get minimumSize {
    return const MaterialStatePropertyAll<Size>(Size.zero);
  }

  @override
  MaterialStateProperty<Size>? get maximumSize {
    return const MaterialStatePropertyAll<Size>(Size.infinite);
  }

  @override
  MaterialTapTargetSize? get tapTargetSize {
    return MaterialTapTargetSize.shrinkWrap;
  }
}
