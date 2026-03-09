import 'dart:async';

import 'package:dr_oplawrence_bible/presentation/bottom_nav/view/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ParentScreen()),
          ),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        title: Text(
          'Quiz',
          style: GoogleFonts.merriweather(
            color: Color(0xFFC70039),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.school, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildJigsawPuzzleGrid(),
            const SizedBox(height: 30),
            _buildChallengesCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildJigsawPuzzleGrid() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1.5,
            mainAxisSpacing: 1.5,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return _buildPuzzlePiece(index);
          },
        ),
      ),
    );
  }

  Widget _buildPuzzlePiece(int index) {
    bool isLocked = index != 0;
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (index == 0)
            Image.asset('assets/images/quiz_background.png', fit: BoxFit.cover),
          if (isLocked)
            Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/quiz_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(decoration: BoxDecoration(color: Colors.white38)),
                  Center(child: Image.asset('assets/icons/lock.png', scale: 3)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChallengesCard(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Morning and Night Challenges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Pass morning and night Bible quiz challenge to unlock the jigsaw',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudyMoreScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCDA434),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============== Quiz Question Section =================
class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What was the name of the first man?',
      'options': ['Eve', 'Seth', 'Cain', 'Adam'],
      'answer': 3,
    },
    {
      'question': 'Who built the ark?',
      'options': ['Abraham', 'Noah', 'Moses', 'David'],
      'answer': 1,
    },
    {
      'question': 'Which city was destroyed by God for its sins?',
      'options': ['Jericho', 'Babylon', 'Sodom', 'Nazareth'],
      'answer': 2,
    },
    {
      'question': 'Who received the Ten Commandments?',
      'options': ['Aaron', 'Moses', 'Joshua', 'Elijah'],
      'answer': 1,
    },
    {
      'question': 'Who was swallowed by a big fish?',
      'options': ['Jonah', 'Peter', 'Paul', 'David'],
      'answer': 0,
    },
  ];

  int _currentQuestionIndex = 0;
  int _selectedOptionIndex = -1;
  bool _isOptionSelected = false;
  double _progress = 0.0;

  void _selectOption(int index) {
    if (_isOptionSelected) return;

    setState(() {
      _selectedOptionIndex = index;
      _isOptionSelected = true;
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _progress = (_currentQuestionIndex + 1) / _questions.length;

        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
          _selectedOptionIndex = -1;
          _isOptionSelected = false;
        } else {
          _showSuccessDialog();
        }
      });
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizScreen()));
            },
            child: Image.asset('assets/images/successfull.png'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(),
              const SizedBox(height: 16),
              _buildQuestionCard(currentQuestion),
              const SizedBox(height: 24),
              ...List.generate(
                currentQuestion['options'].length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildOptionButton(
                    currentQuestion['options'][index],
                    index,
                    index == currentQuestion['answer'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_currentQuestionIndex + 1}/${_questions.length}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Image.asset('assets/icons/slider.png',scale: 3,)
      ],
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${_currentQuestionIndex + 1}/${_questions.length}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            question['question'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String text, int index, bool isCorrect) {
    Color bgColor = Colors.white;
    Color textColor = Colors.black87;

    if (_isOptionSelected && _selectedOptionIndex == index) {
      if (isCorrect) {
        bgColor = Colors.green;
        textColor = Colors.white;
      } else {
        bgColor = Colors.red.shade400;
        textColor = Colors.white;
      }
    }

    return GestureDetector(
      onTap: () => _selectOption(index),
      child: Container(
        width: double.infinity,
        padding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}


// ============= Study More Screen ==================
class StudyMoreScreen extends StatelessWidget {
  const StudyMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
        title: Text(
          'Study More',
          style: GoogleFonts.merriweather(
            color: Color(0xFFC70039),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              _buildLevelCard(context, 'Level 1'),
              const SizedBox(height: 10),
              Text(
                'Keep playing to unlock more levels',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String level) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizQuestionScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border(
            left: BorderSide(
              color: Color(0xffCDA434),
              width: 8,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              level,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                side: BorderSide( color: Color(0xffCDA434),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Reply',
                style: TextStyle( color: Color(0xffCDA434), fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}