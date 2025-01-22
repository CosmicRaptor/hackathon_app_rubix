class QuestionModel {
  final String question;
  final List<String> options;
  final int answerIndex;

  const QuestionModel({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return QuestionModel(
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      answerIndex: json['correct'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct': answerIndex,
    };
  }
}