import 'dart:math';
import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../services/app_state.dart';

class TrueFalsePage extends StatefulWidget {
  const TrueFalsePage({super.key});

  @override
  State<TrueFalsePage> createState() => _TrueFalsePageState();
}

class _TrueFalsePageState extends State<TrueFalsePage> {
  late List<_TrueFalseQuestion> tfQuestions;
  late _TrueFalseQuestion current;
  bool answered = false;
  bool? selectedAnswer;

  @override
  void initState() {
    super.initState();

    tfQuestions = [];

    for (final q in questions) {
      for (int i = 0; i < q.statements.length; i++) {
        tfQuestions.add(
          _TrueFalseQuestion(
            id: q.id * 10 + i,
            category: q.category,
            text: q.statements[i],
            isTrue: q.choices[q.answer].contains(_labelFromIndex(i)),
            explanation: q.explanation,
          ),
        );
      }
    }

    nextQuestion();
  }

  String _labelFromIndex(int index) {
    return ['ア', 'イ', 'ウ', 'エ'][index];
  }

  void nextQuestion() {
    setState(() {
      current = tfQuestions[Random().nextInt(tfQuestions.length)];
      answered = false;
      selectedAnswer = null;
    });
  }

  void answer(bool userAnswer) {
    final isCorrect = userAnswer == current.isTrue;

    setState(() {
      selectedAnswer = userAnswer;
      answered = true;
      AppState.recordAnswer(
        questionId: current.id,
        isCorrect: isCorrect,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCorrect = selectedAnswer == current.isTrue;

    return Scaffold(
      appBar: AppBar(
        title: Text('○×モード：${current.category}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '次の記述は正しいか？',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Text(
            current.text,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 35),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: answered ? null : () => answer(true),
                  child: const Text('○', style: TextStyle(fontSize: 36)),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: answered ? null : () => answer(false),
                  child: const Text('×', style: TextStyle(fontSize: 36)),
                ),
              ),
            ],
          ),

          if (answered) ...[
            const SizedBox(height: 30),
            Text(
              isCorrect ? '⭕ 正解！' : '❌ 不正解',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '正解：${current.isTrue ? "○" : "×"}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              '解説：${current.explanation}',
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

class _TrueFalseQuestion {
  final int id;
  final String category;
  final String text;
  final bool isTrue;
  final String explanation;

  const _TrueFalseQuestion({
    required this.id,
    required this.category,
    required this.text,
    required this.isTrue,
    required this.explanation,
  });
}