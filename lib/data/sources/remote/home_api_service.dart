import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';
import 'package:dr_oplawrence_bible/data/models/home_model.dart';

class HomeApiServices {
  final ApiClient apiClient;

  HomeApiServices({required this.apiClient});
  // =========== Daily verse ==============
  Future<BibleDaily> getDailyVerse() async {
    final response = await apiClient.getRequest(
      endpoints: ApiEndpoints.bibleDaily,
    );

    return BibleDaily.fromJson(response);
  }

  // ============ maditation and prayer ====
  Future<MaditationModel> getMaditationPrayer() async {
    final response = await apiClient.getRequest(
      endpoints: ApiEndpoints.bibleMaditation,
    );
    return MaditationModel.fromJson(response);
  }
}
