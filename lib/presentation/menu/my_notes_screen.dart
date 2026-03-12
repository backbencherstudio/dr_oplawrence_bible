import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:dr_oplawrence_bible/presentation/menu/screens/saved_data/bookmarks_screen.dart';
import 'package:dr_oplawrence_bible/presentation/menu/screens/saved_data/highlight_screen.dart';
import 'package:dr_oplawrence_bible/presentation/menu/screens/saved_data/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sources/local/shared_preference/shared_preference.dart';
import '../bottom_nav/viewmodel/bottom_nav_bar_viewmodel.dart';

class MyNotesScreen extends ConsumerStatefulWidget {
  const MyNotesScreen({super.key});

  @override
  ConsumerState<MyNotesScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends ConsumerState<MyNotesScreen> {
  List<String> bookmarks = [];
  Map<String, String> notes = {};
  Map<String, String> highlights = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final storedBookmarks = prefs.getStringList('bookmarks_list') ?? [];

    final allKeys = prefs.getKeys();
    Map<String, String> tempNotes = {};
    Map<String, String> tempHighlights = {};

    for (var key in allKeys) {
      if (key.startsWith('notes_')) {
        final list = prefs.getStringList(key) ?? [];
        for (var item in list) {
          final parts = item.split('|');
          tempNotes['${key}_${parts[0]}'] = parts[1];
        }
      } else if (key.startsWith('highlight_')) {
        final list = prefs.getStringList(key) ?? [];
        for (var index in list) {
          tempHighlights['${key}_$index'] = 'Highlighted verse $index';
        }
      }
    }

    setState(() {
      bookmarks = storedBookmarks;
      notes = tempNotes;
      highlights = tempHighlights;
      isLoading = false;
    });
  }

  void _openBookmarksScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookmarksScreen()),
    );
  }

  void _openNotesScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => NotesScreen()));
  }

  void _openHighlightsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HighlightsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffEBEBEB),
        title: Text(
          'My Notes',
          style: GoogleFonts.merriweather(
            color: const Color(0xffB02626),
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding:  EdgeInsets.all(16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ================ Save Notes =================
                      GestureDetector(
                        onTap: _openNotesScreen,
                        child: Container(
                          width: 95.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30.w,
                                height: 30.h,
                                child: SvgPicture.asset(
                                  'assets/icons/notes_icon.svg',
                                  width: 28.w,
                                  height: 28.h,
                                ),
                              ),
                               SizedBox(height: 6.h),
                              const Text('Notes'),
                            ],
                          ),
                        ),
                      ),
                       SizedBox(width: 10.w),
                      // ================ Save Book mark =============
                      GestureDetector(
                        onTap: _openBookmarksScreen,
                        child: Container(
                          width: 95.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset('assets/icons/alert_triangle.svg'),
                              SizedBox(
                                width: 30.w,
                                height: 33.h,
                                child: Icon(
                                  Icons.bookmark,
                                  color: Color(0xffB02626),
                                  size: 40,
                                ),
                              ),
                               SizedBox(height: 6.h),
                              const Text('Bookmark'),
                            ],
                          ),
                        ),
                      ),
                       SizedBox(width: 10.w),
                      // ============= Save Highlight ================
                      GestureDetector(
                        onTap: _openHighlightsScreen,
                        child: Container(
                          width: 95.w,
                          height: 90.h,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30.w,
                                height: 30.h,
                                child: SvgPicture.asset(
                                  'assets/icons/Highlights.svg',
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text('Highlight'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Stack(
                    children: [
                      Image.asset('assets/images/menu_bird.png'),

                      Positioned(
                        top: 100.h,
                        left: 10.w,
                        right: 10.w,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Giving is not losing, it is planting hope.\n The smallest gift can spark the\n greatest change.',
                        ),
                      ),
                      Positioned(
                        bottom: 100.h,
                        left: 10.w,
                        right: 10.w,
                        child: Padding(
                          padding:  EdgeInsets.only(left: 60.0.w, right: 60.w),
                          child: SizedBox(
                            width: 100.w,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.donateMoneySystem,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffCDA434),
                              ),
                              child:  Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text('Donate Money'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),

                  // =========== LogOut Button =================
                  SizedBox(
                    width: 300.w, // button width
                    height: 50.h, // button height
                    child: ElevatedButton(
                      onPressed: () async {
                          ref.read(bottomNavBarProvider.notifier).onItemTapped(0);
                        // Clear saved data
                        await SharedPreferenceData.removeToken();
                        await SharedPreferenceData.removeRole();
                        await SharedPreferenceData().removeEmailId();

                        // Navigate to login screen
                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.loginScreen,
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffB02626),
                        padding:  EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(
                        'Exit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors
                              .white, // replace ColorsManager.whiteColor if needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

abstract class BaseListScreen extends StatefulWidget {
  const BaseListScreen({super.key});

  Future<Map<String, String>> fetchData();
}

abstract class BaseListScreenState<T extends BaseListScreen> extends State<T> {
  Map<String, String> data = {};
  bool isLoading = true;

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    data = await widget.fetchData();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  String _cleanKey(String rawKey) {
    return rawKey.replaceAll('_', ' ').split(' ').skip(1).join(' ').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          getTitle(),
          style: GoogleFonts.merriweather(
            color: const Color(0xffB02626),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: data.isEmpty
                  ? Center(
                      child: Text(
                        'No ${getTitle().toLowerCase()} yet',
                        style:  TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding:  EdgeInsets.all(16.w),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final key = data.keys.elementAt(index);
                        final value = data.values.elementAt(index);

                        return Container(
                          margin:  EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 8.w,
                          ),
                          padding:  EdgeInsets.all(18.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border(
                              left: BorderSide(
                                color: const Color(0xffB02626),
                                width: 6,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xffB02626,
                                ).withOpacity(0.18),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(0, 8),
                              ),
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.12),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:  EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffB02626,
                                  ).withOpacity(0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.auto_stories,
                                  color: Color(0xffB02626),
                                  size: 28,
                                ),
                              ),

                               SizedBox(width: 16.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_cleanKey(key).isNotEmpty)
                                      Text(
                                        _cleanKey(key).toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xffB02626),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    if (_cleanKey(key).isNotEmpty)
                                       SizedBox(height: 8.h),

                                    Text(
                                      value,
                                      style:  TextStyle(
                                        fontSize: 16.5.sp,
                                        height: 1.7.h,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  String getTitle();
}

Future<void> logout(BuildContext context) async {
  // Remove saved data
  await SharedPreferenceData.removeToken();
  await SharedPreferenceData.removeRole();
  await SharedPreferenceData().removeEmailId();

  // Navigate to login screen and remove all previous screens
  Navigator.pushNamedAndRemoveUntil(
    context,
    RouteNames.loginScreen,
    (route) => false,
  );
}
