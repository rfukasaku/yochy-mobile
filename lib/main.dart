import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'util/routes.dart';
import 'util/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final launchedCount = prefs.getInt('launchedCount') ?? 0;
  await prefs.setInt('launchedCount', launchedCount + 1);

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
      onGenerateRoute: Routes.generateRoute,
      onUnknownRoute: Routes.errorRoute,
    );
  }
}
