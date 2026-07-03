class AppState {
  static int totalAnswered = 0;
  static int correctAnswered = 0;

  static final Set<int> wrongQuestionIds = {};

  static void recordAnswer({
    required int questionId,
    required bool isCorrect,
  }) {
    totalAnswered++;

    if (isCorrect) {
      correctAnswered++;
      wrongQuestionIds.remove(questionId);
    } else {
      wrongQuestionIds.add(questionId);
    }
  }

  static int get wrongCount => wrongQuestionIds.length;

  static int get correctRate {
    if (totalAnswered == 0) return 0;
    return (correctAnswered / totalAnswered * 100).round();
  }
}