import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:dr_oplawrence_bible/core/resource/values_manager.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SizedBox(
            height: Utils.fullHeight(context)*0.80,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hello")
                    ]
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
