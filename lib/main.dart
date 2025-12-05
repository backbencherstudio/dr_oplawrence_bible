import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/route/route_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dr Oplawrence Bible',
          theme: getApplicationTheme(),
          themeMode: ThemeMode.system,

          // These two lines fix everything
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes, // ← NOW THIS WORKS!

          // home: const SplashScreen(), // you can keep this instead if you want
        );
      },
    );
  }
}