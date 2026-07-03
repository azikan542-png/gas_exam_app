class Question {
  final int id;
  final String category;

  final String question;

  final List<String> statements;

  final List<String> choices;

  final int answer;

  final String explanation;

  const Question({
    required this.id,
    required this.category,
    required this.question,
    required this.statements,
    required this.choices,
    required this.answer,
    required this.explanation,
  });
}