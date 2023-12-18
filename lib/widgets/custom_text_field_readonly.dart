import 'package:flutter/material.dart';

class TextFieldReadOnly extends StatelessWidget {
  TextFieldReadOnly(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.readOnly,
      this.controller});

  String? hintText;

  Icon? suffixIcon;

  bool? readOnly;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          controller: controller ?? TextEditingController(),
          textAlign: TextAlign.center,
          readOnly: readOnly ?? true,
          decoration: InputDecoration(
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
