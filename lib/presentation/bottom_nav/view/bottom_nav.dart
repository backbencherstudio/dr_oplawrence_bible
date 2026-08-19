import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../home/book/view/book_screen.dart';
import '../../home/view/screens/home_screen.dart';
import '../../menu/my_notes_screen.dart';
import '../../plan/view/plan_Screen.dart';
import '../viewmodel/bottom_nav_bar_viewmodel.dart';

class ParentScreen extends ConsumerWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navParentProvider = ref.watch(bottomNavBarProvider);
    // final bibleVM = BibleViewModel();

    final List<Widget> pages = [
      HomeScreen(),
      // LottieScreen(),
      BookListScreen(),

      // BookListScreen(bibleVM: bibleVM),
      VideoStoriesScreen(),
      //GlossaryScreen(),
      MyNotesScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        left: false,
        right: false,
        top: false,
        bottom: true,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: navParentProvider,
                    children: pages,
                  ),
                ),

                Container(
                  height: 100.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          topLeft: Radius.circular(30.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildNavigationBar(
                            context: context,
                            ref: ref,
                            index: 0,
                            label: 'Home',
                            iconPath: 'assets/icons/homes.svg',
                            baseSize: 27,
                            selectedIconColor: const Color(0xff0D5593),
                          ),
                          _buildNavigationBar(
                            context: context,
                            ref: ref,
                            index: 1,
                            label: 'Bible',
                            iconPath: 'assets/icons/Bible.svg',
                            baseSize: 27,
                            selectedIconColor: const Color(0xff0D5593),
                          ),
                          _buildNavigationBar(
                            context: context,
                            ref: ref,
                            index: 2,
                            label: 'Plan',
                            iconPath: 'assets/icons/plan.svg',
                            baseSize: 24,
                            selectedIconColor: const Color(0xff0D5593),
                          ),
                          _buildNavigationBar(
                            context: context,
                            ref: ref,
                            index: 3,
                            label: 'Menu',
                            iconPath: 'assets/icons/menu.svg',
                            baseSize: 25,
                            selectedIconColor: const Color(0xff0D5593),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBar({
    required BuildContext context,
    required WidgetRef ref,
    required int index,
    required String label,
    required String iconPath,
    required double baseSize,
    required Color selectedIconColor,
  }) {
    final navProvider = ref.watch(bottomNavBarProvider);
    final isSelected = navProvider == index;

    final double iconSize = isSelected ? (baseSize + 4).w : baseSize.w;

    return SizedBox(
      width: 60.w,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () =>
                  ref.read(bottomNavBarProvider.notifier).onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                child: SvgPicture.asset(
                  iconPath,
                  width: iconSize,
                  height: iconSize,
                  color: isSelected
                      ? const Color(0xff0D5593)
                      : const Color(0xff4C4C4C),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? selectedIconColor : const Color(0xff4C4C4C),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
