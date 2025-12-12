import 'package:dr_oplawrence_bible/presentation/book/screens/chapter_tab_view_screen.dart';
import 'package:dr_oplawrence_bible/presentation/book/screens/verses_tab_view_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BibleBook {
  final String name;
  final List<Chapter> chapters;

  BibleBook({required this.name, required this.chapters});

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      name: json["name"],
      chapters: (json["chapters"] as List)
          .map((c) => Chapter.fromJson(c))
          .toList(),
    );
  }
}

class Chapter {
  final int number;
  final List<String> verses;

  Chapter({required this.number, required this.verses});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      number: json["number"],
      verses: List<String>.from(json["verses"]),
    );
  }
}

class BibleViewModel {
  Future<List<BibleBook>> loadBooks() async {
    final jsonString = await rootBundle.loadString('assets/book/books.json');
    final jsonMap = json.decode(jsonString);
    return (jsonMap["books"] as List)
        .map((b) => BibleBook.fromJson(b))
        .toList();
  }
}

class BookListScreen extends StatefulWidget {
  final BibleViewModel bibleVM;

  const BookListScreen({required this.bibleVM, super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  BibleBook? selectedBook;
  Chapter? selectedChapter;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  void goToChapterTab(BibleBook book) {
    setState(() => selectedBook = book);
    tabController.animateTo(1);
  }

  void goToVerseTab(Chapter chapter, BibleBook book) {
    setState(() {
      selectedBook = book;
      selectedChapter = chapter;
    });
    tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),

      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        title: Text(
          'Index',
          style:
          GoogleFonts.merriweather(color: const Color(0xffB02626), fontSize: 20),
        ),
      ),

      body: FutureBuilder<List<BibleBook>>(
        future: widget.bibleVM.loadBooks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final books = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 15,
              children: [
                buildSearchField(),

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

                const SizedBox(height: 10),

                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [

                      ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  title: Text(book.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle:
                                  Text("${book.chapters.length} Chapters"),
                                  trailing: const Text(
                                    '0%',
                                    style: TextStyle(
                                        color: Color(0xffCDA434),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),

                                  onTap: () {
                                    goToChapterTab(book);
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                        },
                      ),


                      selectedBook == null
                          ? const Center(child: Text("Select a book"))
                          : ChapterTabView(
                        book: selectedBook!,
                        onSelectChapter: (chapter) {
                          goToVerseTab(chapter, selectedBook!);
                        },
                      ),


                      (selectedBook == null || selectedChapter == null)
                          ? const Center(child: Text("Select a chapter"))
                          : VerseTabView(
                        chapter: selectedChapter!,
                        bookName: selectedBook!.name,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchField() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        hintText: "Search",
        hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}