import 'package:dr_oplawrence_bible/core/resource/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/route/route_config.dart';
import '/core/route/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Default design size
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dr Oplawrence Bible',
          theme: getApplicationTheme(),
          themeMode: ThemeMode.system,
          initialRoute: AppRoutes.initialRoute,

          // home: child,
        );
      },
      // child: const SizedBox.shrink(), // Placeholder, replaced by routes
    );
  }
}
