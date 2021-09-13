import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/index.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key}) : super(key: key);
  static const route = '/play';
  static const url = 'https://yochy-cea25.web.app/play/?from=mobile';
  static const endMessage = '終了しますか？';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return showConfirmModal(context, endMessage);
      },
      child: Scaffold(
        appBar: simpleAppBar(context, 'あそぶ'),
        body: CustomWebView(
          url: url,
          onLoadResourceCustomScheme: (controller, _) async {
            final url = await controller.getUrl();
            await controller.stopLoading();
            final action = url.toString().replaceAll('yochy-mobile:', '');
            if (action == 'backToHomePage') {
              if (await showConfirmModal(context, endMessage)) {
                Navigator.pop(context);
              }
              return;
            }
            if (action == 'showErrorModal') {
              showErrorModal(
                context,
                'エラーが発生しました。この画面を閉じて終了してください。',
              );
            }
          },
        ),
      ),
    );
  }
}
