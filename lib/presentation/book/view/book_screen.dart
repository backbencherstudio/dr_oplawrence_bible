import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/data/repository/bible_repository.dart';
import 'package:dr_oplawrence_bible/presentation/book/verse/view/verse_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/network/api_clients.dart';
import '../../../data/sources/remote/bible_api_services.dart';
import '../viewmodel/bible_books_riverpod.dart';

class BookListScreen extends ConsumerStatefulWidget {
  const BookListScreen({super.key});

  @override
  ConsumerState<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends ConsumerState<BookListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  /// ================= PROGRESS CALCULATION =================
  double calculateProgress({
    required String bookId,
    required int totalChapters,
    required Map<String, Set<String>> progressMap,
  }) {
    final completed = progressMap[bookId]?.length ?? 0;

    if (totalChapters == 0) return 0;

    return (completed / totalChapters) * 100;
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
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildSearchField(),
            const SizedBox(height: 15),

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

            const SizedBox(height: 10),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  /// =================1st  BOOK TAB =================
                  Consumer(
                    builder: (context, ref, child) {
                      final booksAsync = ref.watch(bibleBooksProvider);
                      final selectedIndex = ref.watch(
                        selectedBookIndexProvider,
                      );
                      final progressMap = ref.watch(completedChaptersProvider);

                      return booksAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Center(child: Text("Error: $err")),
                        data: (books) {
                          return ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              final isSelected = selectedIndex == index;

                              final chapterCountAsync = ref.watch(
                                bookChapterCountProvider(book.id),
                              );

                              return GestureDetector(
                                onTap: () {
                                  ref
                                          .read(
                                            selectedBookIndexProvider.notifier,
                                          )
                                          .state =
                                      index;

                                  ref
                                      .read(selectedBookNameProvider.notifier)
                                      .state = book
                                      .name;

                                  tabController.animateTo(1);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorsManager.deepAmber
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  child: chapterCountAsync.when(
                                    loading: () => ListTile(
                                      title: Text(book.name),
                                      trailing:
                                          const CircularProgressIndicator(),
                                    ),

                                    error: (e, _) => ListTile(
                                      title: Text(book.name),
                                      subtitle: const Text("Error"),
                                    ),

                                    data: (totalChapters) {
                                      final percent = calculateProgress(
                                        bookId: book.id,
                                        totalChapters: totalChapters,
                                        progressMap: progressMap,
                                      );

                                      return ListTile(
                                        title: Text(
                                          book.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? ColorsManager.whiteColor
                                                : ColorsManager.blackColor,
                                          ),
                                        ),

                                        trailing: Text(
                                          "${percent.toStringAsFixed(0)}%",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? ColorsManager.whiteColor
                                                : ColorsManager.deepAmber,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  /// =================2nd CHAPTER TAB =================
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
                            Center(child: Text("Error: $err")),
                        data: (books) {
                          if (selectedIndex == null) {
                            return const Center(
                              child: Text("Select a book first"),
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
                                Center(child: Text("Error: $err")),
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
                                  final isSelected = selectedIndex2 == index;

                                  return GestureDetector(
                                    onTap: () {
                                      ref
                                              .read(
                                                selectedChapterIndexProvider
                                                    .notifier,
                                              )
                                              .state =
                                          index;

                                      /// MARK CHAPTER COMPLETED
                                      final progressMap = ref.read(
                                        completedChaptersProvider,
                                      );

                                      final updated =
                                          Map<String, Set<String>>.from(
                                            progressMap,
                                          );

                                      updated.putIfAbsent(bookId, () => {});
                                      updated[bookId]!.add(chapter.id);

                                      ref
                                              .read(
                                                completedChaptersProvider
                                                    .notifier,
                                              )
                                              .state =
                                          updated;

                                      ref
                                              .read(
                                                selectedChapterNumberProvider
                                                    .notifier,
                                              )
                                              .state =
                                          chapter.number;

                                      tabController.animateTo(2);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? ColorsManager.deepAmber
                                            : ColorsManager.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        chapter.number.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
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

                  /// =================3rd VERSE TAB =================
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedBook = ref.watch(selectedBookIndexProvider);
                      final selectedChapter = ref.watch(
                        selectedChapterIndexProvider,
                      );

                      final booksAsync = ref.watch(bibleBooksProvider);

                      return booksAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) =>
                            Center(child: Text("Error: $err")),
                        data: (books) {
                          if (selectedBook == null || selectedChapter == null) {
                            return const Center(
                              child: Text("Select chapter first"),
                            );
                          }

                          final bookId = books[selectedBook].id;

                          final chaptersAsync = ref.watch(
                            bibleChapterProvider(bookId),
                          );

                          final apiClient = ApiClient();
                          final bibleRepository = BibleRepository(
                            apiService: BibleApiServices(apiClient: apiClient),
                          );

                          return chaptersAsync.when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (err, stack) =>
                                Center(child: Text("Error: $err")),
                            data: (chapters) {
                              final chapterId = chapters[selectedChapter].id;

                              final versesAsync = ref.watch(
                                bibleVerseProvider(chapterId),
                              );

                              return versesAsync.when(
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (err, stack) =>
                                    Center(child: Text("Error: $err")),
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
                                      final verse = verses[index];

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => VerseScreen(
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
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            verse.number.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
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

  /// ================= SEARCH =================
  Widget buildSearchField() {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
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
