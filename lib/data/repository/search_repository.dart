import '../models/search_model.dart';
import '../sources/remote/search_api_services.dart';

class SearchRepository {
  final SearchApiServices apiServices;

  SearchRepository({required this.apiServices});

  // ================= Search Bible =================
  Future<SearchModel> searchBible(String topic) async {
    return await apiServices.searchBible(topic);
  }
}