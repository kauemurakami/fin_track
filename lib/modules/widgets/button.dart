import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.callback,
    required this.text,
    this.width,
    this.height,
    this.margin,
    this.color,
  });
  final VoidCallback callback;
  final String text;
  final double? width, height;
  final EdgeInsets? margin;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: MaterialButton(
        minWidth: width,
        height: height ?? 42.0,
        color: color ?? Theme.of(context).buttonTheme.colorScheme?.surface,
        onPressed: callback,
        child: Text(
          text,
          // style: TextStyle(
          //   color: Colors.white,
          // ),
        ),
      ),
    );
  }
}
