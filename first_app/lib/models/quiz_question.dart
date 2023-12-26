class QuizQuestion {
  const QuizQuestion(this.text, this.answers, this.answer);

  final String text;
  final List<String> answers;
  final String answer;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
