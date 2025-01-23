class Riddle {
  final String question;
  final String answer;
  final String hint;
  final String? imageUrl;

  Riddle({
    required this.question,
    required this.answer,
    required this.hint,
    this.imageUrl,
  });

  factory Riddle.fromJson(Map<String, dynamic> json) {
    return Riddle(
      question: json['question'],
      answer: json['answer'],
      hint: json['hint'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'hint': hint,
      'imageUrl': imageUrl,
    };
  }
}
