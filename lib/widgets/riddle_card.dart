import 'package:flutter/material.dart';
import '../models/riddle_model.dart';

class RiddleCard extends StatefulWidget {
  final Riddle riddle;
  final Function(bool) onSubmit;

  const RiddleCard({
    super.key,
    required this.riddle,
    required this.onSubmit,
  });

  @override
  State<RiddleCard> createState() => _RiddleCardState();
}

class _RiddleCardState extends State<RiddleCard> {
  bool isHintVisible = false;
  final TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Image if exists
            if (widget.riddle.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.riddle.imageUrl!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            // Question
            Text(
              widget.riddle.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            //answer textfield
            TextField(
              controller: answerController,
              decoration: const InputDecoration(
                hintText: 'Enter your answer',
                border: OutlineInputBorder(),
              ),
            ),

            // Hint Button
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isHintVisible = !isHintVisible;
                });
              },
              icon: Icon(
                isHintVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.blue,
              ),
              label: Text(
                isHintVisible ? 'Hide Hint' : 'Reveal Hint',
                style: const TextStyle(color: Colors.blue),
              ),
            ),

            // Hint Text
            if (isHintVisible)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.riddle.hint,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 16),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                final isCorrect = widget.riddle.answer
                    .toLowerCase()
                    .contains(answerController.text.toLowerCase());
                widget.onSubmit(isCorrect);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit Answer',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
