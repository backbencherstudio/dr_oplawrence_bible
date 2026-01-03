import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../book/book_screen.dart';
import '../../book/screens/glossary/glossary_screen.dart';
import '../../home/view/home_screen.dart';
import '../../home/view/screens/lottie_Screen.dart';
import '../../menu/my_notes_screen.dart';

final parentScreenProvider =
ChangeNotifierProvider<ParentScreenProvider>((ref) {
  return ParentScreenProvider();
});

class ParentScreenProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class ParentScreen extends ConsumerWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navParentProvider = ref.watch(parentScreenProvider);
    final bibleVM = BibleViewModel();

    final List<Widget> pages = [
      HomeScreen(),
     // LottieScreen(),
      BookListScreen(bibleVM: bibleVM),
      GlossaryScreen(),
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
                    index: navParentProvider.selectedIndex,
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
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
                            iconPath: 'assets/icons/books.svg',
                            baseSize: 27,
                            selectedIconColor: const Color(0xff0D5593),
                          ),
                          _buildNavigationBar(
                            context: context,
                            ref: ref,
                            index: 2,
                            label: 'Glossary',
                            iconPath: 'assets/icons/notes_icon.svg',
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
    final navProvider = ref.watch(parentScreenProvider);
    final isSelected = navProvider.selectedIndex == index;

    final double iconSize =
    isSelected ? (baseSize + 4).w : baseSize.w;

    return SizedBox(
      width: 60.w,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => ref
                  .read(parentScreenProvider.notifier)
                  .changeIndex(index),
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
                color:
                isSelected ? selectedIconColor : const Color(0xff4C4C4C),
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
