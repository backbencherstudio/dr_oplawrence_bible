import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 30),
            _buildSectionTitle('Topics'),
            _buildTopicChips(),
            const SizedBox(height: 30),
            _buildSectionTitle('History'),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      controller: _searchController,
      onFieldSubmitted: (value) {
        _saveToHistory(value);
        _searchController.clear();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
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

  Widget _buildHistoryList() {
    if (_historyList.isEmpty) {
      return const Text(
        'No history yet',
        style: TextStyle(color: Colors.grey),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _historyList.map((item) {
        return Container(
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
        );
      }).toList(),
    );
  }

  Widget _buildTopicChips() {
    return Column(
      spacing: 15,
      children: [
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _topicChip('Any Topic'),
            _iconChip('Barakat', 'assets/icons/barakat.svg'),
            _iconChip('Peace', 'assets/icons/peace.svg'),
          ],
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconChip('Love', 'assets/icons/love.svg'),
            _iconChip('Salvation', 'assets/icons/Salvation.svg'),
            _iconChip('Faith', 'assets/icons/Faith.svg'),
          ],
        ),
      ],
    );
  }

  Widget _topicChip(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Color(0xff1A1A1A)),
      ),
    );
  }

  Widget _iconChip(String label, String iconPath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(iconPath),
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Color(0xff1A1A1A)),
          ),
        ],
      ),
    );
  }
}
