import 'package:flutter/material.dart';

class Tff extends StatelessWidget {
  final Function(String s)? onSaved;
  final Function(String s)? onValidate;
  final Function(String s)? onChanged;
  final TextInputType? type;
  final String? label, initialValue;
  final bool? obscureText;
  const Tff({
    super.key,
    this.type = TextInputType.text,
    this.initialValue,
    this.onValidate,
    this.onChanged,
    this.onSaved,
    this.label,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      initialValue: initialValue,
      onSaved: (v) => onSaved!(v!),
      validator: (v) => onValidate!(v!),
      onChanged: (v) => onChanged!(v),
      keyboardType: type,
      // style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black87),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 12.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: .85, color: Colors.deepPurple),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.4, color: Colors.deepPurple),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: .85, color: Colors.deepPurple),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: .85,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: .85,
          ),
        ),

        errorMaxLines: 1,
        errorStyle: const TextStyle(
          fontSize: 11.0,
          height: .1,
          color: Colors.red,
        ),
        label: Text(label ?? ''),
        // labelStyle: const TextStyle(color: Colors.black, fontSize: 17.0),
      ),
    );
  }
}
