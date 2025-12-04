import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:dr_oplawrence_bible/presentation/bottom_nav/view/bottom_nav.dart';
import 'package:dr_oplawrence_bible/presentation/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.navbar:
        return MaterialPageRoute(builder: (_) => const BottomNav());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
