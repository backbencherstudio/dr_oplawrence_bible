import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:dr_oplawrence_bible/presentation/menu/screens/saved_data/bookmarks_screen.dart';
import 'package:dr_oplawrence_bible/presentation/menu/screens/saved_data/highlight_screen.dart';
import 'package:dr_oplawrence_bible/presentation/menu/screens/saved_data/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNotesScreen extends StatefulWidget {
  const MyNotesScreen({super.key});

  @override
  State<MyNotesScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends State<MyNotesScreen> {
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
      MaterialPageRoute(
        builder: (_) => BookmarksScreen(),
      ),
    );
  }

  void _openNotesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotesScreen(),
      ),
    );
  }

  void _openHighlightsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HighlightsScreen(),
      ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

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
                            child: SvgPicture.asset('assets/icons/notes_icon.svg',width: 28.w,height: 28.h,)),
                        const SizedBox(height: 6),
                        const Text('Notes'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

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
                            child: Icon(Icons.bookmark,color: Color(0xffB02626),size: 40,)),
                        const SizedBox(height: 6),
                        const Text('Bookmark'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

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
                            child: SvgPicture.asset('assets/icons/Highlights.svg',width: 30.w,height: 30.h,)),
                        const SizedBox(height: 6),
                        const Text('Highlight'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h,),
            Stack(
              children: [
                Image.asset('assets/images/menu_bird.png'),

                Positioned(
                  top: 100,
                  left: 10,
                  right: 10,
                  child: Text(
                      textAlign: TextAlign.center,
                      'Giving is not losing, it is planting hope.\n The smallest gift can spark the\n greatest change.'),
                ),
                Positioned(
                  bottom: 100,
                  left: 10,
                  right: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0,right: 60),
                    child: SizedBox(
                      width: 100.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.donateMoneySystem);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffCDA434),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Donate Money'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // const Spacer(),
            // SizedBox(
            //   width: 200.w,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, RouteNames.donateMoneySystem);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xffCDA434),
            //     ),
            //     child: const Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: Text('Donate Money'),
            //     ),
            //   ),
            // ),
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
          style: GoogleFonts.merriweather(color: const Color(0xffB02626), fontSize: 20),
        ),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadData,
        child: data.isEmpty
            ? Center(child: Text('No ${getTitle().toLowerCase()} yet'))
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final key = data.keys.elementAt(index);
            final value = data.values.elementAt(index);
            return Card(
              child: ListTile(
                title: Text(value),
                subtitle: Text(key),
              ),
            );
          },
        ),
      ),
    );
  }

  String getTitle();
}