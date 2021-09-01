import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);
  static const route = '/error';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'エラーが発生しました',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
