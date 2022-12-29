// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:todo/app/views/category_view.dart';
import 'package:todo/app/views/home_view.dart';

class Routes {
  static final Routes instance = Routes._();
  Routes._();

  // Name of Routes
  final String HOME = '/';
  final String CATEGORY = '/category';

  // Initial Route
  String get initialRoute => HOME;

  // Routes map
  Map<String, Widget Function(BuildContext)> get routes => {
    HOME: (context) => const HomeView(),
    CATEGORY: (context)  => const CategoryView(),
  };
}