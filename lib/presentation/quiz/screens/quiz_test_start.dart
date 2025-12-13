import 'dart:async';
import 'package:dr_oplawrence_bible/presentation/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';

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
