import 'dart:math';
import 'package:flutter/material.dart';

import '../models/question.dart';
import '../services/app_state.dart';

class ExamPage extends StatefulWidget {
  final List<Question> sourceQuestions;

  const ExamPage({
    super.key,
    required this.sourceQuestions,
  });

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  late List<Question> remainingQuestions;
  late Question question;
  int? selectedIndex;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    remainingQuestions = [...widget.sourceQuestions];
    nextQuestion();
  }

  void nextQuestion() {
    setState(() {
      if (remainingQuestions.isEmpty) {
        remainingQuestions = [...widget.sourceQuestions];
      }

      final index = Random().nextInt(remainingQuestions.length);
      question = remainingQuestions.removeAt(index);
      selectedIndex = null;
      answered = false;
    });
  }

  void answer(int index) {
    final isCorrect = index == question.answer;

    setState(() {
      selectedIndex = index;
      answered = true;
      AppState.recordAnswer(
        questionId: question.id,
        isCorrect: isCorrect,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect = selectedIndex == question.answer;

    return Scaffold(
      appBar: AppBar(
        title: Text('試験モード：${question.category}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('問題ID：${question.id}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 15),
          Text(
            question.question,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          for (final s in question.statements)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(s, style: const TextStyle(fontSize: 19)),
            ),

          const SizedBox(height: 20),

          for (int i = 0; i < question.choices.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: answered ? null : () => answer(i),
                child: Text(
                  '${i + 1}. ${question.choices[i]}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),

          if (answered) ...[
            const SizedBox(height: 20),
            Text(
              isCorrect ? '⭕ 正解！' : '❌ 不正解',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '正解：${question.answer + 1}. ${question.choices[question.answer]}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              '解説：${question.explanation}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: nextQuestion,
              child: const Text('次の問題へ', style: TextStyle(fontSize: 20)),
            ),
          ],
        ],
      ),
    );
  }
}