import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ui/components/index.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  static const route = '/about';
  static const url = 'https://yochy-cea25.web.app/about/?from=mobile';
  static const contactFormUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSetLQIcyNt628Er-HqRlPGZKZP97a095m7O8lvtUNO2dv4S8Q/viewform?usp=sf_link';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context, 'このアプリについて'),
      body: CustomWebView(
        url: url,
        onLoadResourceCustomScheme: (controller, _) async {
          final url = await controller.getUrl();
          await controller.stopLoading();
          final action = url.toString().replaceAll('yochy-mobile:', '');
          if (action == 'openContactForm') {
            if (await canLaunch(contactFormUrl)) {
              await launch(contactFormUrl);
            } else {
              showErrorModal(context, 'エラーが発生しました');
            }
          }
        },
      ),
    );
  }
}
