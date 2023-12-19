import 'package:flutter/material.dart';

class TextFieldReadOnly extends StatelessWidget {
  TextFieldReadOnly(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.readOnly,
      this.controller,
      this.onTap,
      this.fillColor});

  String? hintText;

  Icon? suffixIcon;

  bool? readOnly;

  void Function()? onTap;

  TextEditingController? controller;

  Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          onTap: onTap ?? () {},
          controller: controller ?? TextEditingController(),
          textAlign: TextAlign.center,
          readOnly: readOnly ?? true,
          decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white,
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              alignLabelWithHint: false,
              hintText: hintText,
              suffixIcon: suffixIcon ??
                  const SizedBox(
                    width: 0,
                    height: 0,
                  ))),
    );
  }
}
