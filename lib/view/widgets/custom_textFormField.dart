import 'package:flutter/material.dart';

import '../../config/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?) validatorFn;
  final Function(String?) onSavedFn;
  final String initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? icon;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.validatorFn,
    required this.onSavedFn,
    this.icon,
    this.initialValue = '',
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hintColor,
              fontSize: 13,
            ),
            icon: Icon(icon, size: 20, color: darkGreenColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor)),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          initialValue: initialValue,
          validator: validatorFn,
          onSaved: onSavedFn,
        ),
      ],
    );
  }
}
