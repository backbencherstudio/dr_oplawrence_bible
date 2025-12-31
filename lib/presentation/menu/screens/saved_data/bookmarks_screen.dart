import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Bookmarks Screen
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
            return Card(
              child: ListTile(
                leading: const Icon(Icons.bookmark, color: Colors.amber),
                title: Text('${parts[0]} ${parts[1]}:${int.parse(parts[2]) + 1}'),
                subtitle: Text(parts[3]),
              ),
            );
          },
        ),
      ),
    );
  }
}