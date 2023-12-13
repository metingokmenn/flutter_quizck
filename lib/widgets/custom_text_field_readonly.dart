import 'package:flutter/material.dart';

class TextFieldReadOnly extends StatelessWidget {
  TextFieldReadOnly({
    super.key,
    this.hintText,
  });

  String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          textAlign: TextAlign.center,
          readOnly: true,
          decoration: InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            alignLabelWithHint: false,
            hintText: hintText,
          )),
    );
  }
}
