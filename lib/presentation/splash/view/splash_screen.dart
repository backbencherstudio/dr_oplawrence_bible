import 'dart:async';
import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/image_manager.dart';
import 'package:flutter/material.dart';
import '../../../core/route/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // int x = 1;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
    //  if(x==1) {Navigator.pushReplacementNamed(
    //     context,
    //     RouteNames.agencyBottomNavBarScreen,
    //   );}
    // else { Navigator.pushReplacementNamed(
    //     context,
    //     RouteNames.careBottomNavBarScreen,
    //   );}
    Navigator.pushReplacementNamed(
        context,
        RouteNames.navbar,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: ColorsManager.splashBgColor,
      body: Center(child: Image.asset(ImageManager.logo)),

    );
  }
}
