import '../models/bible_model.dart';
import '../sources/remote/bible_api_services.dart';

class BibleRepository {
  final BibleApiServices apiService;

  BibleRepository({required this.apiService});

  // ================= Get Bible Books =================
  Future<dynamic> getBibleBooks() async {
    return await apiService.getBibleBooks();
  }
  // =============== Get Bible Chapter =================
  Future<dynamic> getBibleChapter(String bookId) async {
    return await apiService.getBibleChapter(bookId);
    
  }
  // =============== Get Bible Verse =================
  Future<dynamic> getBibleVerse(String chapterId) async {
    return await apiService.getBibleVerse(chapterId);
    
  }

  // ================= Bible Explanation =================
  Future<BibleAiExplanationModel> getBibleExplanation({
  required String bookName,
  required int chapter,
  required int verseNumber,
}) async {
  return await apiService.getBibleExplanation(
    bookName: bookName,
    chapter: chapter,
    verseNumber: verseNumber,
  );
}
  

}
