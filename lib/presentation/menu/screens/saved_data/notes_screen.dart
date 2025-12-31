import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../my_notes_screen.dart';

// Notes Screen
class NotesScreen extends BaseListScreen {
  const NotesScreen({super.key});

  @override
  Future<Map<String, String>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> tempNotes = {};
    final allKeys = prefs.getKeys();
    for (var key in allKeys) {
      if (key.startsWith('notes_')) {
        final list = prefs.getStringList(key) ?? [];
        for (var item in list) {
          final parts = item.split('|');
          tempNotes['${key}_${parts[0]}'] = parts[1];
        }
      }
    }
    return tempNotes;
  }

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends BaseListScreenState<NotesScreen> {
  @override
  String getTitle() => 'Notes';
}