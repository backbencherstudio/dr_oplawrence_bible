import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../my_notes_screen.dart';


// Highlights Screen
class HighlightsScreen extends BaseListScreen {
  const HighlightsScreen({super.key});

  @override
  Future<Map<String, String>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> tempHighlights = {};
    final allKeys = prefs.getKeys();
    for (var key in allKeys) {
      if (key.startsWith('highlight_')) {
        final list = prefs.getStringList(key) ?? [];
        for (var index in list) {
          tempHighlights['${key}_$index'] = 'Highlighted verse $index';
        }
      }
    }
    return tempHighlights;
  }

  @override
  State<HighlightsScreen> createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends BaseListScreenState<HighlightsScreen> {
  @override
  String getTitle() => 'Highlights';
}