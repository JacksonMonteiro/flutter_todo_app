import 'package:flutter/material.dart';
import 'package:todo/app/utils/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.instance.routes,
      initialRoute: Routes.instance.initialRoute,
    );
  }
}