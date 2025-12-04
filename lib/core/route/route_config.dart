// import 'package:dr_oplawrence_bible/core/route/route_name.dart';
// import 'package:dr_oplawrence_bible/presentation/bottom_nav/view/bottom_nav.dart';
// import 'package:dr_oplawrence_bible/presentation/splash/view/splash_screen.dart';
// import 'package:flutter/material.dart';
//
// import '../../presentation/book/book_screen.dart';
//
// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RouteNames.splashScreen:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case RouteNames.chapterListScreen:
//         return MaterialPageRoute(builder: (_) =>  BookListScreen(bibleVM: bibleVM,));
//       case RouteNames.navbar:
//         return MaterialPageRoute(builder: (_) => const BottomNav());
//       default:
//         return MaterialPageRoute(
//           builder: (_) =>
//               const Scaffold(body: Center(child: Text('Route not found'))),
//         );
//     }
//   }
// }
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/book/book_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
 // contains BibleViewModel

class AppRoutes {
  static final BibleViewModel bibleVM = BibleViewModel();
  static final String initialRoute = RouteNames.bookListScreen;

  static late final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),


    // Show list of all books
    RouteNames.bookListScreen: (context) => BookListScreen(bibleVM: bibleVM),
  };
}
