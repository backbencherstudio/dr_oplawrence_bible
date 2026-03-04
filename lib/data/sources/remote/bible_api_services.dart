import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';

class BibleApiServices {
  final ApiClient apiClient;

  BibleApiServices({required this.apiClient});

  // ================= Bible Books =================
  Future<dynamic> getBibleBooks() async {
    return await apiClient.getRequest(endpoints: ApiEndpoints.bibleBooks);
  }

  // ================= Bible Chapter =================
  Future<dynamic> getBibleChapter(String bookId) async {
    return await apiClient.getRequest(
      endpoints: "${ApiEndpoints.bibleChapters}?bookId=$bookId",
    );
  }

  // ================= Bible verses =================
  Future<dynamic> getBibleVerse(String chapterId) async {
    return await apiClient.getRequest(
      endpoints: "${ApiEndpoints.bibleVerse}?chapterId=$chapterId",
    );
  }
}
