import 'package:flutter/material.dart';

import '../components/index.dart';
import 'about_page.dart';
import 'play_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = '/';
  static const url = 'https://yochy-cea25.web.app/?from=mobile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context, 'ホーム'),
      body: CustomWebView(
        url: url,
        onLoadResourceCustomScheme: (controller, _) async {
          final url = await controller.getUrl();
          await controller.stopLoading();
          final action = url.toString().replaceAll('yochy-mobile:', '');
          if (action == 'goToPlayPage') {
            await Navigator.pushNamed(context, PlayPage.route);
            return;
          }
          if (action == 'goToAboutPage') {
            await Navigator.pushNamed(context, AboutPage.route);
          }
        },
      ),
    );
  }
}
