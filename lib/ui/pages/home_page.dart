import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/index.dart';
import 'about_page.dart';
import 'play_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const route = '/';

  final url = 'https://yochy-cea25.web.app/?from=mobile';
  final inAppReview = InAppReview.instance;

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

            try {
              final prefs = await SharedPreferences.getInstance();
              final playCount = prefs.getInt('playCount') ?? 0;
              final newPlayCount = playCount + 1;
              await prefs.setInt('playCount', newPlayCount);

              // NOTE: 2回目または100回に1回、レビュー依頼を出す
              if (newPlayCount == 2 || newPlayCount % 100 == 0) {
                if (await inAppReview.isAvailable()) {
                  await inAppReview.requestReview();
                }
              }
            } on Exception catch (e) {
              debugPrint(e.toString());
            }
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
