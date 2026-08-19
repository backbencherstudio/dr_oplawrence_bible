import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/bible_search_field.dart';
import 'widgets/books_tab.dart';
import 'widgets/chapters_tab.dart';
import 'widgets/verses_tab.dart';

class BibleScreen extends ConsumerStatefulWidget {
  const BibleScreen({super.key});

  @override
  ConsumerState<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends ConsumerState<BibleScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),

      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        automaticallyImplyLeading: false,
        title: Text(
          'Index',
          style: GoogleFonts.merriweather(
            color: const Color(0xffB02626),
            fontSize: 20.sp,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            BibleSearchField(controller: searchController),
            SizedBox(height: 15.h),

            /// ================= TAB BAR =================
            TabBar(
              controller: tabController,
              indicatorColor: const Color(0xffB02626),
              labelColor: const Color(0xffB02626),
              unselectedLabelColor: Colors.black,
              labelStyle: GoogleFonts.merriweather(fontSize: 16),
              tabs: const [
                Tab(text: "Books"),
                Tab(text: "Chapter"),
                Tab(text: "Verses"),
              ],
            ),

            SizedBox(height: 10.h),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  BooksTab(onBookSelected: (_) => tabController.animateTo(1)),
                  ChaptersTab(
                    onChapterSelected: (_) => tabController.animateTo(2),
                  ),
                  const VersesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    tabController.dispose();
    super.dispose();
  }
}

