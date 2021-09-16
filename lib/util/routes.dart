import 'package:flutter/material.dart';

import '../ui/pages/index.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  try {
    switch (routeSettings.name) {
      case AboutPage.route:
        return MaterialPageRoute<dynamic>(
          settings: routeSettings,
          builder: (_) => const AboutPage(),
        );
      case HomePage.route:
        return MaterialPageRoute<dynamic>(
          settings: routeSettings,
          builder: (_) => const HomePage(),
        );
      case PlayPage.route:
        return MaterialPageRoute<dynamic>(
          settings: routeSettings,
          fullscreenDialog: true,
          builder: (_) => const PlayPage(),
        );
      default:
        return errorRoute(routeSettings);
    }
  } on Exception catch (_) {
    return errorRoute(routeSettings);
  }
}

Route<dynamic> errorRoute(RouteSettings routeSettings) {
  return MaterialPageRoute<dynamic>(
    settings: routeSettings,
    builder: (_) => const ErrorPage(),
  );
}
