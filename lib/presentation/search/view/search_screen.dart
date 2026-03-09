import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodel/search_riverpod.dart';

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

  /// ================= Load History =================
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _historyList = prefs.getStringList('search_history') ?? [];
    });
  }

  /// ================= Save History =================
  Future<void> _saveToHistory(String value) async {
    if (value.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _historyList.remove(value);
      _historyList.insert(0, value);
    });

    await prefs.setStringList('search_history', _historyList);
  }

  /// ================= Remove History =================
  Future<void> _removeHistoryItem(String value) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _historyList.remove(value);
    });

    await prefs.setStringList('search_history', _historyList);
  }

  /// ================= Trigger Search =================
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
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 30),

            /// ================= Topics =================
            _buildSectionTitle('Topics'),
            _buildTopicChips(),
            const SizedBox(height: 30),

            /// ================= History =================
            _buildSectionTitle('History'),
            _buildHistoryList(),
            SizedBox(height: 30.h),

            /// ================= Search Result =================
            _buildSectionTitle('Search List'),

            topic.isEmpty
                ? const Center(child: Text("Search something..."))
                : searchResult.when(
                    data: (data) {
                      if (data == null ||
                          data.data == null ||
                          data.data!.isEmpty) {
                        return const Center(child: Text("No Results Found"));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.data!.length,
                        itemBuilder: (context, index) {
                          final verse = data.data![index];

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Verse Text
                                  Text(
                                    verse.text ?? "",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  /// Reference
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffB02626),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        verse.reference ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
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

  /// ================= Search Bar =================
  Widget _buildSearchBar() {
    return TextFormField(
      controller: _searchController,
      onFieldSubmitted: (value) {
        _performSearch(value);
        _searchController.clear();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        hintText: "Search",
        hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black54),
        ),
      ),
    );
  }

  /// ================= Section Title =================
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  /// ================= History =================
  Widget _buildHistoryList() {
    if (_historyList.isEmpty) {
      return const Text("No history yet", style: TextStyle(color: Colors.grey));
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _historyList.map((item) {
        return GestureDetector(
          onTap: () => _performSearch(item),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff1A1A1A),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _removeHistoryItem(item),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  /// ================= Topics =================
  Widget _buildTopicChips() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconChip('Barakat', 'assets/icons/barakat.svg'),
            const SizedBox(width: 10),
            _iconChip('Peace', 'assets/icons/peace.svg'),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconChip('Love', 'assets/icons/love.svg'),
            const SizedBox(width: 10),
            _iconChip('Salvation', 'assets/icons/Salvation.svg'),
            const SizedBox(width: 10),
            _iconChip('Faith', 'assets/icons/Faith.svg'),
          ],
        ),
      ],
    );
  }

  Widget _iconChip(String label, String iconPath) {
    return GestureDetector(
      onTap: () => _performSearch(label),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 18.sp, color: const Color(0xff1A1A1A)),
            ),
          ],
        ),
      ),
    );
  }
}
