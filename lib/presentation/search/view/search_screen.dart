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
        padding:  EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
             SizedBox(height: 30.h),

            /// ================= Topics =================
            _buildSectionTitle('Topics'),
            _buildTopicChips(),
             SizedBox(height: 30.h),

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
                            margin:  EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(14.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Verse Text
                                  Text(
                                    verse.text ?? "",
                                    style:  TextStyle(
                                      fontSize: 15.sp,
                                      height: 1.5.h,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                   SizedBox(height: 10.h),

                                  /// Reference
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding:  EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffB02626),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Text(
                                        verse.reference ?? "",
                                        style:  TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
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
        contentPadding:  EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 20.w,
        ),
        hintText: "Search",
        hintStyle:  TextStyle(fontSize: 16.sp, color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide:  BorderSide(color: Colors.black54),
        ),
      ),
    );
  }

  /// ================= Section Title =================
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style:  TextStyle(
          fontSize: 20.sp,
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
            padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item,
                  style:  TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xff1A1A1A),
                  ),
                ),
                 SizedBox(width: 8.w),
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
             SizedBox(width: 10.w),
            _iconChip('Peace', 'assets/icons/peace.svg'),
          ],
        ),
         SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconChip('Love', 'assets/icons/love.svg'),
             SizedBox(width: 10.w),
            _iconChip('Salvation', 'assets/icons/Salvation.svg'),
             SizedBox(width: 10.w),
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
             SizedBox(width: 8.w),
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
