import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/widgets/feature_card.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/widgets/nav_row_button.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/widgets/prayer_of_day_card.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/widgets/quick_action_button.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/widgets/word_chip_wrap.dart';
import 'package:dr_oplawrence_bible/presentation/home/viewmodel/home_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/home_header_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _wordsOfTheDay = [
    WordChipData(iconAssetPath: 'assets/icons/barakat.svg', label: 'Barakat'),
    WordChipData(iconAssetPath: 'assets/icons/peace.svg', label: 'Peace'),
    WordChipData(iconAssetPath: 'assets/icons/love.svg', label: 'Love'),
    WordChipData(
      iconAssetPath: 'assets/icons/Salvation.svg',
      label: 'Salvation',
    ),
    WordChipData(iconAssetPath: 'assets/icons/Faith.svg', label: 'Faith'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyVerse = ref.watch(dailyVerseProvider);

    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      body: SizedBox(
        height: Utils.fullHeight(context) * 0.80.h,
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderSection(
                asyncValue: dailyVerse,
                verseTextBuilder: (data) => data.verse?.text ?? "",
                referenceBuilder: (data) => data.verse?.reference ?? "",
              ),
              Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prayer of the day',
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: const Color(0xff1A1A1A),
                      ),
                    ),
                    PrayerOfDayCard(
                      asyncValue: dailyVerse,
                      textBuilder: (data) => data.prayer ?? "",
                      backgroundImageAssetPath: 'assets/images/prayer_day.png',
                    ),
                    FeatureCard(
                      title: 'Morning Pray',
                      subtitle: 'Start Your Day With This Verse',
                      iconAssetPath: 'assets/images/tree.svg',
                      onPressed: () => Navigator.pushNamed(
                        context,
                        RouteNames.morningPrayerScreen,
                      ),
                    ),
                    FeatureCard(
                      title: 'Gospel & Psalms of the Day',
                      subtitle: 'Start Your Day With This Verse',
                      iconAssetPath: 'assets/images/star.svg',
                      onPressed: () => Navigator.pushNamed(
                        context,
                        RouteNames.gospelPsalmScreen,
                      ),
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        QuickActionButton(
                          icon: SvgPicture.asset(
                            'assets/icons/quiz.svg',
                            width: 40.w,
                            height: 40.h,
                          ),
                          label: 'Quiz',
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteNames.quizQuestionScreen,
                          ),
                        ),
                        QuickActionButton(
                          icon: SizedBox(
                            width: 43.w,
                            height: 43.h,
                            child: Image.asset('assets/icons/login_icons.png'),
                          ),
                          label: 'Bible',
                          labelFontSize: 18,
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteNames.bookListScreen,
                          ),
                        ),
                        QuickActionButton(
                          icon: SizedBox(
                            width: 43.w,
                            height: 43.h,
                            child: SvgPicture.asset(
                              'assets/icons/searching.svg',
                            ),
                          ),
                          label: 'Search',
                          labelFontSize: 18,
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteNames.searchScreen,
                          ),
                        ),
                      ],
                    ),
                    NavRowButton(
                      icon: SvgPicture.asset('assets/icons/greetings.svg'),
                      label: 'Archived Daily Devotionals',
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteNames.archievedDailyDevotionalsScreen,
                      ),
                    ),
                    Text(
                      "YAHAWAH ELOHIYM's words for today",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                        color: const Color(0xff4A4A4A),
                      ),
                    ),
                    const WordChipWrap(chips: _wordsOfTheDay),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
