import 'package:flutter/material.dart';

import 'Pages/home_page.dart';
import 'Pages/spalsh_page.dart';

Route Function(RouteSettings) get routes => (RouteSettings settings) {
      Route route;

      switch (settings.name) {
        case "home":
          route = MaterialPageRoute(
            builder: (_) => const HomePage(),
            settings: RouteSettings(name: settings.name),
          );
          break;
        default:
          route = MaterialPageRoute(
            builder: (_) => const SplashPage(),
            settings: RouteSettings(name: settings.name),
          );
          break;
      }

      return route;
    };
