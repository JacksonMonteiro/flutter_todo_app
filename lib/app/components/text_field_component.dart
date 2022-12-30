
import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;
  final TextInputAction? action;

  const TextFieldComponent({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.onSubmitted,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: action,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}