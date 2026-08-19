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

import '../../presentation/auth/logIn/createPass/view/create_pass.dart';
import '../../presentation/auth/logIn/forgotPass/view/forgot_pass.dart';
import '../../presentation/auth/logIn/view/login_screen.dart';
import '../../presentation/auth/logIn/otp/view/otp_screen.dart';
import '../../presentation/auth/signup/otp/view/otp_signup_screen.dart';
import '../../presentation/auth/signup/view/sign_up_screen.dart';
import '../../presentation/bible/view/bible_screen.dart';
import '../../presentation/bible/screens/glossary/glossary_screen.dart';
import '../../presentation/bottom_nav/view/bottom_nav.dart';
import '../../presentation/home/view/screens/home_screen.dart';
import '../../presentation/home/view/screens/archieved_daily_devotionals/archieved_daily_devotionals_screen.dart';
import '../../presentation/home/view/screens/gospel_psalm/gospel_psalm_screen.dart';
import '../../presentation/home/view/screens/morning_prayer/view/morning_prayer_screen.dart';
import '../../presentation/home/view/screens/morning_prayer/view/prayer_screen.dart';
import '../../presentation/menu/my_notes_screen.dart';
import '../../presentation/menu/screens/donate_money.dart';
import '../../presentation/menu/screens/donate_money_system.dart';
import '../../presentation/menu/screens/saved_data/highlight_screen.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/onboarding/second_onboarding.dart';
import '../../presentation/home/quiz/quizQuestion/view/quiz_question_screen.dart';
import '../../presentation/home/quiz/view/quiz_screen.dart';
import '../../presentation/home/search/view/search_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
// contains BibleViewModel

class AppRoutes {
  // static final BibleViewModel bibleVM = BibleViewModel();
  static final String initialRoute = RouteNames.splashScreen;

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onboardingScreen: (context) => const OnboardingScreen(),
    RouteNames.secondOnboarding: (context) => const SecondOnboarding(),
    RouteNames.loginScreen: (context) => const LoginScreen(),
    RouteNames.signUpScreen: (context) => const SignUpScreen(),
    RouteNames.createPass: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final email = args['email']!;
      final token = args['token']!;
      return CreatePass(email: email, token: token);
    },
    RouteNames.forgotPass: (context) => const ForgotPass(),
    RouteNames.otpScreen: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final email = args != null ? args['email'] as String : '';
      return OtpScreen(email: email);
    },
    RouteNames.homeScreen: (context) => const HomeScreen(),
    RouteNames.parentScreen: (context) => const ParentScreen(),
    RouteNames.morningPrayerScreen: (context) => const MorningPrayerScreen(),
    RouteNames.gospelPsalmScreen: (context) => const GospelPsalmScreen(),
    RouteNames.archievedDailyDevotionalsScreen: (context) =>
        const ArchievedDailyDevotionalsScreen(),
    RouteNames.searchScreen: (context) => const SearchScreen(),
    //RouteNames.videoStoriesScreen: (context) => const VideoStoriesScreen(),
    RouteNames.quizScreen: (context) => const QuizScreen(),
    //RouteNames.studyMoreScreen: (context) => const StudyMoreScreen(),
    RouteNames.quizQuestionScreen: (context) => const QuizQuestionScreen(),
    RouteNames.myNotesScreen: (context) => const MyNotesScreen(),
    RouteNames.donateMoneySystem: (context) => const DonateMoneySystem(),
    RouteNames.donationScreen: (context) => const DonationScreen(),
    RouteNames.prayerScreen: (context) => const PrayerScreen(),
    RouteNames.glossaryScreen: (context) => const GlossaryScreen(),
    RouteNames.highlightsScreen: (context) => const HighlightsScreen(),
    RouteNames.signupOtpScreen: (context) {
      final email = ModalRoute.of(context)!.settings.arguments as String;
      return OtpSignupScreen(email: email);
    },

    RouteNames.bibleScreen: (context) => const BibleScreen(),
  };
}
