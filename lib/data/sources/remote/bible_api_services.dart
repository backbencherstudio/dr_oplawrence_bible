import 'package:dr_oplawrence_bible/data/models/bible_model.dart';

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

  // ================== Bible Notes ==================
  Future<BibleNote> bibleNote({
    required String verseId,
    required String note,
    required String reference,
  }) async {
    final body = {"verseId": verseId, "note": note, "reference": reference};
    final response = await ApiClient.postRequest(
      endpoints: ApiEndpoints.bibleNotes,
      body: body,
    );
    return BibleNote.fromJson(response);
  }

  // ================= Bible AI Explanation =================
  Future<BibleAiExplanationModel> getBibleExplanation({
  required String bookName,
  required int chapter,
  required int verseNumber,
}) async {

  final body = {
    "bookName": bookName,
    "chapter": chapter,
    "verseNumber": verseNumber
  };

  final response = await ApiClient.postRequest(
    endpoints: ApiEndpoints.bibleExplain,
    body: body,
  );

  return BibleAiExplanationModel.fromJson(response);
}
}
