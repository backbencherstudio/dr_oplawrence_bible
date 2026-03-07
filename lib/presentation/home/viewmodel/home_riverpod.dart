import 'package:dr_oplawrence_bible/data/repository/home_repository.dart';
import 'package:dr_oplawrence_bible/data/sources/remote/home_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_clients.dart';
import '../../../data/models/home_model.dart';

final bibleRepositoryProvider = Provider((ref) {
  return HomeRepository(
    apiService: HomeApiServices(apiClient: ApiClient()),
  );
});

final dailyVerseProvider = FutureProvider<BibleDaily>((ref) async {
  final repo = ref.read(bibleRepositoryProvider);
  return repo.getDailyVerse();
});