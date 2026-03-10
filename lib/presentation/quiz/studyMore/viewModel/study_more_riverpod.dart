import 'package:flutter_riverpod/flutter_riverpod.dart';

final levelsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return const [
    {'name': 'Level 1', 'level': 1, 'isUnlocked': true},
    {'name': 'Level 2', 'level': 2, 'isUnlocked': true},
    {'name': 'Level 3', 'level': 3, 'isUnlocked': false},
    {'name': 'Level 4', 'level': 4, 'isUnlocked': false},
  ];
});