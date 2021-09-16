import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_colors.dart';
import '../components/index.dart';
import 'about_page.dart';
import 'play_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = 'https://yochy-cea25.web.app/?from=mobile';
  final inAppReview = InAppReview.instance;
  final widgetsBinding = WidgetsBinding.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context, 'ホーム'),
      body: FutureBuilder(
        future: _getLaunchedCount(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          // 2回目の起動時または20回ごとに1回、レビュー依頼を出す
          final launchedCount = snapshot.data! as int;
          if (launchedCount == 2 || launchedCount % 20 == 0) {
            widgetsBinding!.addPostFrameCallback((_) async {
              if (await inAppReview.isAvailable()) {
                await inAppReview.requestReview();
              }
            });
          }

          return CustomWebView(
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
          );
        },
      ),
    );
  }

  Future<int> _getLaunchedCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('launchedCount') ?? 0;
  }
}
