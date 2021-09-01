import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatefulWidget {
  const CustomWebView({
    Key? key,
    required this.url,
    this.onLoadResourceCustomScheme,
  }) : super(key: key);

  final String url;
  final Future<CustomSchemeResponse?> Function(InAppWebViewController, Uri)?
      onLoadResourceCustomScheme;

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  bool loading = true;

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
              clearCache: false,
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
          onLoadResourceCustomScheme: widget.onLoadResourceCustomScheme,
          onProgressChanged: (_, progress) {
            if (progress == 100) {
              setState(() => loading = false);
            }
          },
        ),
        loading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFFDF711B)),
              )
            : Container(),
      ],
    );
  }
}
