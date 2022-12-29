import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final String name;
  final List tasks;
  final Color? color;

  Category({
    required this.icon,
    required this.name,
    required this.tasks,
    required this.color,
  });
}