import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';
import '../../models/search_model.dart';

class SearchApiServices {
  final ApiClient apiClient;

  SearchApiServices({required this.apiClient});

  // ================= Search Bible =================
  Future<SearchModel> searchBible(String topic) async {
    final response = await apiClient.getRequest(
      endpoints: "${ApiEndpoints.bibleSearch}?topic=$topic&page=1&limit=20",
    );

    return SearchModel.fromJson(response);
  }
}