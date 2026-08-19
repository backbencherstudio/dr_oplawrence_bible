import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodel/search_riverpod.dart';
import 'widgets/search_app_bar.dart';
import 'widgets/search_field.dart';
import 'widgets/search_history_chips.dart';
import 'widgets/search_result_list.dart';
import 'widgets/search_topic_chips.dart';
import 'widgets/section_title.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _historyList = prefs.getStringList('search_history') ?? [];
    });
  }

  Future<void> _saveToHistory(String value) async {
    if (value.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _historyList.remove(value);
      _historyList.insert(0, value);
    });

    await prefs.setStringList('search_history', _historyList);
  }

  Future<void> _removeHistoryItem(String value) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _historyList.remove(value);
    });

    await prefs.setStringList('search_history', _historyList);
  }

  void _performSearch(String value) {
    if (value.trim().isEmpty) return;

    _saveToHistory(value);
    ref.read(topicProvider.notifier).state = value;
  }

  @override
  Widget build(BuildContext context) {
    final topic = ref.watch(topicProvider);
    final searchResult = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      appBar: SearchAppBar(onBack: () => Navigator.pop(context)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              controller: _searchController,
              onSubmitted: (value) {
                _performSearch(value);
                _searchController.clear();
              },
            ),
            SizedBox(height: 30.h),

            const SectionTitle('Topics'),
            SearchTopicChips(onTopicTap: _performSearch),
            SizedBox(height: 30.h),

            const SectionTitle('History'),
            SearchHistoryChips(
              items: _historyList,
              onTap: _performSearch,
              onRemove: _removeHistoryItem,
            ),
            SizedBox(height: 30.h),

            const SectionTitle('Search List'),

            topic.isEmpty
                ? const Center(child: Text("Search something..."))
                : searchResult.when(
                    data: (data) {
                      if (data == null ||
                          data.data == null ||
                          data.data!.isEmpty) {
                        return const Center(child: Text("No Results Found"));
                      }

                      return SearchResultList(verses: data.data!);
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text(e.toString())),
                  ),
          ],
        ),
      ),
    );
  }
}