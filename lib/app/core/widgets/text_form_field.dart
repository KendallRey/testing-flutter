import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.obscureText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: label),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
    );
  }
}
