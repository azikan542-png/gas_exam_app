import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../services/app_state.dart';
import '../widgets/menu_button.dart';
import 'exam_page.dart';
import 'score_page.dart';
import 'true_false_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final wrongCount = AppState.wrongCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AW高圧ガス勉強会'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Icon(Icons.school, size: 80, color: Colors.blue),
            const SizedBox(height: 15),
            const Text(
              '丙種化学特別試験検定対策アプリ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 35),

            MenuButton(
              icon: Icons.menu_book,
              text: '試験モード（ランダム）',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExamPage(sourceQuestions: questions),
                  ),
                );
              },
            ),

            MenuButton(
              icon: Icons.refresh,
              text: '間違えた問題だけ（$wrongCount問）',
              onTap: () {
                final wrongQuestions = questions
                    .where((q) => AppState.wrongQuestionIds.contains(q.id))
                    .toList();

                if (wrongQuestions.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('まだ間違えた問題がありません')),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExamPage(sourceQuestions: wrongQuestions),
                  ),
                );
              },
            ),

            MenuButton(
              icon: Icons.bar_chart,
              text: '成績',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScorePage()),
                );
              },
            ),

            MenuButton(
              icon: Icons.check_circle,
              text: '○×モード',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TrueFalsePage()),
                );
              },
            ),

            MenuButton(
              icon: Icons.settings,
              text: '設定（後で追加）',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}