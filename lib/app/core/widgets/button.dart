import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double fontSize;
  final double width;
  final double height;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.fontSize = 16.0,
    this.width = 200.0,
    this.height = 40.0
  });
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width, height), // Set button size
                textStyle: TextStyle(fontSize: fontSize), // Set the text size
              ),
              child: Text(label),
            );
  }
}