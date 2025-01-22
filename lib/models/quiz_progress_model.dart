class QuizProgressModel {
  final String uid;
  final int correctAnswers;
  final int totalQuestions;
  final int level;

  QuizProgressModel({
    required this.uid,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.level,
  });

  factory QuizProgressModel.fromMap(Map<String, dynamic> map) {
    return QuizProgressModel(
      uid: map['uid'] as String,
      correctAnswers: map['correctAnswers'] as int,
      totalQuestions: map['totalQuestions'] as int,
      level: map['level'] as int,
    );
  }
}
