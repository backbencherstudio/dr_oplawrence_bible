import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/screens/morning_prayer/viewmodel/morning_prayer_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/labled_row_section.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/verse_of_the_day_header.dart';

class MorningPrayerScreen extends ConsumerStatefulWidget {
  const MorningPrayerScreen({super.key});

  @override
  ConsumerState<MorningPrayerScreen> createState() =>
      _MorningPrayerScreenState();
}

class _MorningPrayerScreenState extends ConsumerState<MorningPrayerScreen> {
  @override
  Widget build(BuildContext context) {
    final morningPrayer = ref.watch(morningPrayerRiverpod);

    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerseOfTheDayHeader(
              asyncValue: morningPrayer,
              referenceBuilder: (data) => data.maditaionVerse?.reference,
              verseTextBuilder: (data) => data.maditaionVerse?.text ?? "",
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    spacing: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LabeledVerseSection(
                        title: 'Meditation',
                        asyncValue: morningPrayer,
                        textBuilder: (data) => data.maditaionVerse?.text ?? '',
                      ),
                      SizedBox(height: 10.h),
                      LabeledVerseSection(
                        title: 'Pray',
                        asyncValue: morningPrayer,
                        textBuilder: (data) => data.prayer ?? "",
                      ),
                      SizedBox(height: 10.h),
                      PrimaryActionButton(
                        label: 'Omnah',
                        backgroundColor: const Color(0xffCDA434),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          RouteNames.prayerScreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
