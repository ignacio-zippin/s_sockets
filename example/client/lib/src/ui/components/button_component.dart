//* Flutter imports

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';
import '../../utils/extensions.dart';

//* Project imports

class ButtonComponent extends StatefulWidget {
  final VoidCallback onPressed;
  final String? text;
  final TextStyle? textStyle;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;
  // O se puede pasar completo un nuevo buttonStyle:
  final ButtonStyle? buttonStyle;

  const ButtonComponent({
    Key? key,
    required this.onPressed,
    this.text,
    this.textStyle = const TextStyle(
      fontSize: kFontSize40,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    this.icon,
    this.backgroundColor,
    this.disabledColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.width,
    this.height,
    this.elevation,
    this.padding,
    this.isEnabled = true,
    this.buttonStyle,
  }) : super(key: key);

  @override
  ButtonComponentState createState() => ButtonComponentState();
}

class ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isEnabled ? widget.onPressed : () {},
      style: widget.buttonStyle ?? _defaultButtonStyle(),
      child: _content(),
    );
  }

  _content() {
    if (widget.icon != null && widget.text.hasValue()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: widget.icon!,
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 3,
            child: FittedBox(
              child: Text(
                widget.text!,
                style: widget.textStyle,
              ),
            ),
          )
        ],
      );
    } else if (widget.text.hasValue()) {
      return FittedBox(
        child: Text(
          widget.text!,
          style: widget.textStyle,
        ),
      );
    } else if (widget.icon != null) {
      return widget.icon;
    } else {
      return const Text("-");
    }
  }

  _defaultButtonStyle() {
    return ButtonStyle(
      splashFactory: widget.isEnabled ? null : NoSplash.splashFactory,
      backgroundColor: MaterialStatePropertyAll<Color>(
        widget.isEnabled
            ? (widget.backgroundColor ?? kPrimary)
            : (widget.disabledColor ??
                widget.backgroundColor?.withOpacity(0.4) ??
                kPrimary.withOpacity(0.4)),
      ),
      side: MaterialStatePropertyAll<BorderSide?>(
        BorderSide(
          color: widget.isEnabled
              ? (widget.borderColor ?? Colors.transparent)
              : (widget.borderColor?.withOpacity(0.4) ?? Colors.transparent),
          width: widget.borderWidth ?? 1.0,
        ),
      ),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
        ),
      ),
      shadowColor: const MaterialStatePropertyAll<Color>(
        Colors.white,
      ),
      elevation: MaterialStatePropertyAll<double>(
        widget.elevation ?? 0.0,
      ),
      maximumSize: const MaterialStatePropertyAll<Size>(
        Size(double.infinity, 200),
      ),
      minimumSize: MaterialStatePropertyAll<Size>(
        Size(widget.width ?? 10, widget.height ?? 30),
      ),
      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
        widget.padding ?? const EdgeInsets.all(10.0),
      ),
    );
  }
}
