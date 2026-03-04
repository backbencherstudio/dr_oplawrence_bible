import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/data/repository/bible_repository.dart';
import 'package:dr_oplawrence_bible/presentation/book/verse/view/verse_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/network/api_clients.dart';
import '../../../data/sources/remote/bible_api_services.dart';
import '../viewmodel/bible_books_riverpod.dart';

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

class BookListScreen extends ConsumerStatefulWidget {
  final BibleViewModel bibleVM;

  const BookListScreen({required this.bibleVM, super.key});

  @override
  ConsumerState<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends ConsumerState<BookListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  BibleBook? selectedBook;
  Chapter? selectedChapter;

  List<BibleBook> books = [];
  List<BibleBook> filteredBooks = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    widget.bibleVM.loadBooks().then((value) {
      setState(() {
        books = value;
        filteredBooks = List.from(books);
      });
    });

    searchController.addListener(_filterBooks);
  }

  void _filterBooks() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredBooks = books
          .where((book) => book.name.toLowerCase().contains(query))
          .toList();
    });
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
        automaticallyImplyLeading: false,

        title: Text(
          'Index',
          style: GoogleFonts.merriweather(
            color: Color(0xffB02626),
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildSearchField(),

            SizedBox(height: 15),

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

            SizedBox(height: 10),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  // ================ First tab ===============
                  Consumer(
                    builder: (context, ref, child) {
                      final booksAsync = ref.watch(bibleBooksProvider);
                      final selectedIndex = ref.watch(
                        selectedBookIndexProvider,
                      );

                      return booksAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Center(child: Text('Error: $err')),
                        data: (books) {
                          return ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              final isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  // Update the selected index when clicked
                                  ref
                                          .read(
                                            selectedBookIndexProvider.notifier,
                                          )
                                          .state =
                                      index;
                                  tabController.animateTo(1);

                                  ref.read(selectedBookNameProvider.notifier).state = books[index].name;
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFCDA434)
                                        : Colors.white, // selected color
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      book.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? ColorsManager.whiteColor
                                            : ColorsManager.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  // ================ Second tab ===============
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedIndex = ref.watch(
                        selectedBookIndexProvider,
                      );
                      final booksAsync = ref.watch(bibleBooksProvider);

                      return booksAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Center(child: Text('Error: $err')),
                        data: (books) {
                          if (selectedIndex == null) {
                            return const Center(
                              child: Text('Select a book first'),
                            );
                          }

                          final bookId = books[selectedIndex].id;

                          final chaptersAsync = ref.watch(
                            bibleChapterProvider(bookId),
                          );

                          return chaptersAsync.when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (err, stack) =>
                                Center(child: Text('Error: $err')),
                            data: (chapters) {
                              final selectedIndex2 = ref.watch(
                                selectedChapterIndexProvider,
                              );

                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 6,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                itemCount: chapters.length,
                                itemBuilder: (context, index) {
                                  final chapter = chapters[index];
                                  final isSelected2 = selectedIndex2 == index;

                                  return GestureDetector(
                                    onTap: () {
                                      ref
                                              .read(
                                                selectedChapterIndexProvider
                                                    .notifier,
                                              )
                                              .state =
                                          index;

                                      tabController.animateTo(2);
                                      ref.read(selectedChapterNumberProvider.notifier).state =
      chapters[index].number;
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected2
                                            ? const Color(0xFFCDA434)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        chapter.number.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isSelected2
                                              ? ColorsManager.whiteColor
                                              : ColorsManager.blackColor,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  // ================== Third tab ==================
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedIndex3 = ref.watch(
                        selectedBookIndexProvider,
                      );
                      final selectedChapterIndex = ref.watch(
                        selectedChapterIndexProvider,
                        
                      );

                      final booksAsync = ref.watch(bibleBooksProvider);

                      return booksAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Center(child: Text('Error: $err')),
                        data: (books) {
                          if (selectedIndex3 == null ||
                              selectedChapterIndex == null) {
                            return const Center(
                              child: Text('Select a chapter first'),
                            );
                          }

                          final bookId = books[selectedIndex3].id;
                          final chaptersAsync = ref.watch(
                            bibleChapterProvider(bookId),
                          );
                          final apiClient = ApiClient(); // your actual instance
                          final bibleRepository = BibleRepository(
                            apiService: BibleApiServices(apiClient: apiClient),
                          );

                          return chaptersAsync.when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (err, stack) =>
                                Center(child: Text('Error: $err')),
                            data: (chapters) {
                              final chapterId =
                                  chapters[selectedChapterIndex].id;

                              final versesAsync = ref.watch(
                                bibleVerseProvider(chapterId),
                              );

                              return versesAsync.when(
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (err, stack) =>
                                    Center(child: Text('Error: $err')),
                                data: (verses) {
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 6,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                        ),
                                    itemCount: verses.length,
                                    itemBuilder: (context, index) {
                                      final chapter = verses[index];
                                      final isSelected2 =
                                          selectedIndex3 == index;

                                      return GestureDetector(
                                        onTap: () {
                                          ref
                                                  .read(
                                                    selectedChapterIndexProvider
                                                        .notifier,
                                                  )
                                                  .state =
                                              index;

                                          // verse onDetails screnn onTap
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VerseScreen(
                                                chapterId: chapterId,
                                                bibleRepository:
                                                    bibleRepository,
                                                
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isSelected2
                                                ? const Color(0xFFCDA434)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            chapter.number.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isSelected2
                                                  ? ColorsManager.whiteColor
                                                  : ColorsManager.blackColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        hintText: "Search",
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
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

  @override
  void dispose() {
    searchController.dispose();
    tabController.dispose();
    super.dispose();
  }
}
