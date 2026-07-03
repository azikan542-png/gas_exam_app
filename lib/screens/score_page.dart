import 'package:flutter/material.dart';
import '../services/app_state.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final total = AppState.totalAnswered;
    final correct = AppState.correctAnswered;
    final wrong = AppState.wrongCount;
    final rate = AppState.correctRate;

    return Scaffold(
      appBar: AppBar(
        title: const Text("成績"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            scoreCard("解いた問題数", "$total 問"),

            scoreCard("正解数", "$correct 問"),

            scoreCard("間違えた問題", "$wrong 問"),

            scoreCard("正答率", "$rate %"),

          ],
        ),
      ),
    );
  }

  Widget scoreCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}