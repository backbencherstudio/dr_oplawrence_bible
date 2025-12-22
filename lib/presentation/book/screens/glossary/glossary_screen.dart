import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'glossary_details_screen.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen>
    with SingleTickerProviderStateMixin {
  Map<String, String> glossaryData = {};
  List<String> filteredKeys = [];
  final TextEditingController _searchController = TextEditingController();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    loadGlossary();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadGlossary() async {
    final String jsonString =
    await rootBundle.loadString('assets/book/glossary.json');

    final Map<String, dynamic> decoded = jsonDecode(jsonString);

    glossaryData =
        decoded.map((key, value) => MapEntry(key, value.toString()));

    filteredKeys = glossaryData.keys.toList();

    setState(() {});
  }

  void searchGlossary(String query) {
    setState(() {
      filteredKeys = glossaryData.keys
          .where(
            (key) => key.toLowerCase().contains(query.toLowerCase()),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Glossary'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF141E30),
                Color(0xFF243B55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: glossaryData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
            child: Column(
                    children: [
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: searchGlossary,
                decoration: InputDecoration(
                  hintText: 'Search keyword...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
            
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
            
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
            
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                itemCount: filteredKeys.length,
                itemBuilder: (context, index) {
                  final key = filteredKeys[index];
            
                  final animation = Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        (index / filteredKeys.length),
                        1,
                        curve: Curves.easeOut,
                      ),
                    ),
                  );
            
                  return SlideTransition(
                    position: animation,
                    child: FadeTransition(
                      opacity: _controller,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GlossaryDetailScreen(
                                  title: key,
                                  description: glossaryData[key]!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF667EEA),
                                  Color(0xFF764BA2),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                key,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 4,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
                    ],
                  ),
          ),
    );
  }
}