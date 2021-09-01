import 'package:flutter/material.dart';

import '../../ui/components/index.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  static const route = '/about';
  static const url = 'https://yochy-cea25.web.app/about/?from=mobile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context, 'このアプリについて'),
      body: const CustomWebView(url: url),
    );
  }
}
