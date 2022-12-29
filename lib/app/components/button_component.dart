import 'dart:io';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const ButtonComponent({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.green[600],
              ),
            ),
            child: Text(label));
  }
}