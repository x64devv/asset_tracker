import 'package:flutter/material.dart';

import '../constants/theme_data.dart';

class CustomFormTextWidget extends StatelessWidget {
  const CustomFormTextWidget({
    Key? key, required this.hint, required this.obscureText, this.controller, required this.keyboardType}) : super(key: key);

  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: textColor
              )
          ),
        ),
      ),
    );
  }
}