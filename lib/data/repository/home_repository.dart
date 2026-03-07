import 'package:dr_oplawrence_bible/data/models/home_model.dart';
import 'package:dr_oplawrence_bible/data/sources/remote/home_api_service.dart';

class HomeRepository {
  final HomeApiServices apiService;

  HomeRepository({required this.apiService});
  // ============ Daily Verse ===============
  Future<BibleDaily> getDailyVerse() async {
    return await apiService.getDailyVerse();
  }
  // ============ maditation Verse ==========
  Future<MaditationModel> getMaditationPrayer() async{
    return await apiService.getMaditationPrayer();
  }
}
