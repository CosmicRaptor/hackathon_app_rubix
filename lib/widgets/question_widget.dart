import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/models/question_model.dart';

class QuestionWidget extends StatefulWidget {
  final QuestionModel question;
  final Function(int, bool) submit;
  final int length;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.submit,
    required this.length,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String selectedOption = '';
  bool didSelectCorrect = false;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question.question,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...widget.question.options.asMap().entries.map((entry) {
          final int index = entry.key;
          final String option = entry.value;

          final isCorrectOption = index == widget.question.answerIndex;
          final isSelectedOption = option == selectedOption;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              //border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isSubmitted && isCorrectOption
                      ? Colors.green
                      : Colors.black,
                ),
              ),
              //bgcolor
              tileColor: isSubmitted && isCorrectOption
                  ? Colors.green[100]
                  : isSubmitted && isSelectedOption && !isCorrectOption
                      ? Colors.red[100]
                      : null,
              title: Text(
                option,
                style: TextStyle(
                  color: isSubmitted && isCorrectOption
                      ? Colors.green
                      : Colors.black,
                  fontWeight:
                      isSubmitted && isCorrectOption ? FontWeight.bold : null,
                ),
              ),
              leading: Radio(
                value: option,
                groupValue: selectedOption,
                onChanged: isSubmitted
                    ? null // Disable interaction after submission
                    : (value) {
                        setState(() {
                          selectedOption = value.toString();
                          didSelectCorrect = selectedOption ==
                              widget.question
                                  .options[widget.question.answerIndex];
                        });
                      },
              ),
              onTap: isSubmitted
                  ? null // Disable interaction after submission
                  : () {
                      setState(() {
                        selectedOption = option;
                        didSelectCorrect = selectedOption ==
                            widget
                                .question.options[widget.question.answerIndex];
                      });
                    },
            ),
          );
        }),
        ElevatedButton(
          onPressed: isSubmitted
              ? null // Disable button after submission
              : () {
                  setState(() {
                    isSubmitted = true; // Mark as submitted
                  });
                  widget.submit(widget.length, didSelectCorrect);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[200],
          ),
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
