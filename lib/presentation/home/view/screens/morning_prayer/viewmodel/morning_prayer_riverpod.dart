import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/data/repository/home_repository.dart';
import 'package:dr_oplawrence_bible/data/sources/remote/home_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final morningDataRiverpod = Provider((ref) {
  return HomeRepository(apiService: HomeApiServices(apiClient: ApiClient()));
});
final morningPrayerRiverpod = FutureProvider((ref) async {
  final repo = ref.read(morningDataRiverpod);
  return repo.getMaditationPrayer();
});
