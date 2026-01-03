import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<String> bookmarks = [];
  bool isLoading = true;

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    bookmarks = prefs.getStringList('bookmarks_list') ?? [];
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
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          'Bookmarks',
          style: GoogleFonts.merriweather(color: const Color(0xffB02626), fontSize: 20),
        ),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadData,
        child: bookmarks.isEmpty
            ? const Center(child: Text('No bookmarks yet'))
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final parts = bookmarks[index].split('|');
            return SizedBox(
              height: 90.h,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                padding: const EdgeInsets.only(left: 8, top: 5),
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
                      color: const Color(0xffB02626).withOpacity(0.18),
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
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xffB02626).withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.bookmarks, color: Color(0xffB02626))),
                  ),
                  title: Text('${parts[0]} ${parts[1]}:${int.parse(parts[2]) + 1}',  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffB02626),
                    letterSpacing: 0.5,
                  ),),
                  subtitle: Text(parts[3], style: const TextStyle(
                    fontSize: 16.5,
                    height: 1.7,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}