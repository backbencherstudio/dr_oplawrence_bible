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

import '../../presentation/auth/create_pass.dart';
import '../../presentation/auth/forgot_pass.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/auth/otp_screen.dart';
import '../../presentation/auth/sign_up_screen.dart';
import '../../presentation/book/book_screen.dart';
import '../../presentation/bottom_nav/view/bottom_nav.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/home/view/screens/archieved_daily_devotionals/archieved_daily_devotionals_Screen.dart';
import '../../presentation/home/view/screens/gospel_psalm/gospel_psalm_screen.dart';
import '../../presentation/home/view/screens/morning_prayer/morning_prayer_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/onboarding/second_onboarding.dart';
import '../../presentation/plan/plan_Screen.dart';
import '../../presentation/quiz/quiz_screen.dart';
import '../../presentation/quiz/screens/quiz_test_start.dart';
import '../../presentation/quiz/screens/study_more.dart';
import '../../presentation/search/search_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
 // contains BibleViewModel

class AppRoutes {
  static final BibleViewModel bibleVM = BibleViewModel();
  static final String initialRoute = RouteNames.splashScreen;

  static late final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onboardingScreen: (context) => const OnboardingScreen(),
    RouteNames.secondOnboarding: (context) => const SecondOnboarding(),
    RouteNames.loginScreen: (context) => const LoginScreen(),
    RouteNames.signUpScreen: (context) => const SignUpScreen(),
    RouteNames.createPass: (context) => const CreatePass(),
    RouteNames.forgotPass: (context) => const ForgotPass(),
    RouteNames.otpScreen: (context) => const OtpScreen(),
    RouteNames.homeScreen: (context) => const HomeScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.morningPrayerScreen: (context) => const MorningPrayerScreen(),
    RouteNames.gospelPsalmScreen: (context) => const GospelPsalmScreen(),
    RouteNames.archievedDailyDevotionalsScreen: (context) => const ArchievedDailyDevotionalsScreen(),
    RouteNames.searchScreen: (context) => const SearchScreen(),
    RouteNames.videoStoriesScreen: (context) => const VideoStoriesScreen(),
    RouteNames.quizScreen: (context) => const QuizScreen(),
    RouteNames.studyMoreScreen: (context) => const StudyMoreScreen(),
    RouteNames.quizQuestionScreen: (context) => const QuizQuestionScreen(),


    RouteNames.bookListScreen: (context) => BookListScreen(bibleVM: bibleVM),
  };
}
