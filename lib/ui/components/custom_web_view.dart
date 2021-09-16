import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../util/app_colors.dart';

class CustomWebView extends StatefulWidget {
  const CustomWebView({
    Key? key,
    required this.url,
    required this.customSchemeAction,
  }) : super(key: key);

  final String url;
  final Future<void> Function(String) customSchemeAction;

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  bool loading = true;
  bool showErrorMessage = false;
  String errorMessage = '読み込みに失敗しました\n\n何度も失敗する場合は\n\nアプリの再起動をお試しください';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              cacheEnabled: false,
              clearCache: true,
              supportZoom: false,
              transparentBackground: true,
              resourceCustomSchemes: const ['yochy-mobile'],
            ),
            ios: IOSInAppWebViewOptions(
              allowsBackForwardNavigationGestures: false,
              allowsLinkPreview: false,
              disableLongPressContextMenuOnLinks: true,
              disallowOverScroll: true,
              enableViewportScale: true,
            ),
          ),
          onLoadResourceCustomScheme: (controller, _) async {
            final url = await controller.getUrl();
            await controller.stopLoading();
            final action = url.toString().replaceAll('yochy-mobile:', '');
            await widget.customSchemeAction(action);
          },
          onProgressChanged: (_, progress) {
            if (progress == 100) {
              setState(() => loading = false);
            }
          },
          onLoadError: (controller, uri, code, message) {
            // NOTE: -999 操作を完了できませんでした。（NSURLErrorDomainエラー-999）
            if (code != -999) {
              setState(() => showErrorMessage = true);
            }
          },
        ),
        showErrorMessage
            ? Center(
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
        loading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : Container(),
      ],
    );
  }
}
