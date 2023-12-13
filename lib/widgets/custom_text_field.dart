import 'package:flutter/material.dart';

class TextFieldWithIconButton extends StatelessWidget {
  TextFieldWithIconButton(
      {super.key,
      this.labelText,
      this.hintText,
      required this.isBold,
      this.readOnly});

  String? labelText;

  String? hintText;

  bool? readOnly;

  bool isBold;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            labelText ?? '',
          ),
          TextFormField(
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown.shade300),
                  borderRadius: BorderRadius.circular(24)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              alignLabelWithHint: false,
              hintText: hintText,
              hintStyle: isBold
                  ? const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black)
                  : const TextStyle(),
              suffixIcon: Container(
                width: 80,
                height: 70,
                decoration: BoxDecoration(
                  border: const Border(
                    right: BorderSide(color: Colors.black26, width: 1),
                    left: BorderSide(color: Colors.black26, width: 1),
                    top: BorderSide(color: Colors.black26, width: 1),
                    bottom: BorderSide(color: Colors.black26, width: 1),
                  ),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.brown.shade400,
                      Colors.brown.shade300,
                      Colors.brown.shade200,
                      Colors.brown.shade100,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color hexToColor(String hexColor) {
    // Remove the leading # if it exists
    hexColor = hexColor.replaceAll("#", "");

    // Parse the hex color code
    int parsedColor = int.parse(hexColor, radix: 16);

    // Return the Color object
    return Color(parsedColor);
  }
}
