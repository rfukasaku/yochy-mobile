import 'package:flutter/material.dart';

import 'util/routes.dart';
import 'util/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ヨッチー',
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      onGenerateRoute: generateRoute,
      onUnknownRoute: errorRoute,
    );
  }
}
