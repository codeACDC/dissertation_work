class LetterModel {
  final String letter;
  final String id;

  LetterModel({
    required this.letter,
    required this.id,
  });
}

class CorrectAnswerModel {
  final String correctAnswer;
  bool? isCorrect;

  CorrectAnswerModel({
    required this.correctAnswer,
    required this.isCorrect,
  });
}
