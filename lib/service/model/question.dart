class Question {
  final int answer;
  final String question;
  final List<String> options;
  int questlvl;

  Question({
    required this.question,
    required this.options,
    required this.answer,
    required this.questlvl
  });
}
