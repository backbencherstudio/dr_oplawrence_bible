import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/presentation/bottom_nav/viewmodel/bottom_nav_bar_viewmodel.dart';
import 'package:dr_oplawrence_bible/presentation/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  final List<Widget> _screens = const [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(bottomNavBarProvider);
    return Scaffold(
      body: _screens[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: ColorsManager.whiteColor, // background color
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.backgroundDark.withValues(alpha: 0.1),
                //spreadRadius: 1.w,
                blurRadius: 10
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BottomNavigationBar(
              backgroundColor: ColorsManager.whiteColor,
              currentIndex: ref.watch(bottomNavBarProvider),
              onTap: ref.read(bottomNavBarProvider.notifier).onItemTapped,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              unselectedItemColor: ColorsManager.primaryColor,
              items: [
                _buildNavItem(isSelected: index == 0),
                _buildNavItem(isSelected: index == 1,),
                _buildNavItem(isSelected: index == 2),
                _buildNavItem(isSelected: index == 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

BottomNavigationBarItem _buildNavItem(
  {String? icon, 
  required bool isSelected,
}) {
  return BottomNavigationBarItem(
    icon: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? ColorsManager
                  .primaryColor // active background
            : ColorsManager.whiteColor, // default background
      ),
      child: (icon != null) ? SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(isSelected
            ? ColorsManager.whiteColor
            : ColorsManager.primaryColor, BlendMode.srcIn),
        height: 24,
      ) : Icon(Icons.bookmark),
    ),
    label: '',
  );
}
