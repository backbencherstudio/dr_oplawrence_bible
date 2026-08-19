import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/api_clients.dart' show ApiClient;
import '../../../../data/models/search_model.dart';
import '../../../../data/repository/search_repository.dart';
import '../../../../data/sources/remote/search_api_services.dart';

/// topic state
final topicProvider = StateProvider<String>((ref) => "");

/// api service
final searchApiServiceProvider = Provider((ref) {
  return SearchApiServices(apiClient: ApiClient());
});

/// repository
final searchRepositoryProvider = Provider((ref) {
  return SearchRepository(apiServices: ref.read(searchApiServiceProvider));
});

/// search provider
final searchProvider = FutureProvider.autoDispose<SearchModel?>((ref) async {
  final topic = ref.watch(topicProvider);

  if (topic.isEmpty) {
    return null;
  }

  final repo = ref.read(searchRepositoryProvider);

  return repo.searchBible(topic);
});
