import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:riverpod/riverpod.dart';

final promptProvider = StateProvider<String>((ref) => '');
final promptLanguageProvider = StateProvider<String>((ref) => 'Old English');

// StreamProvider to watch the stream based on the current prompt
final geminiPromptStreamProvider = StreamProvider<Candidates?>((ref) {
  final prompt = ref.watch(promptProvider); // Get the current prompt
  final promtLang = ref.watch(promptLanguageProvider); // Get the current prompt language

  final geminiService = Gemini.instance; // Replace with actual service
  return geminiService.promptStream(parts: [
    Part.text(
        'Translate the following text into ${promtLang != "Random" ? promtLang : "an ancient language of your choice"}.'
            ' Only provide the translation in a single string. '
            ' After the translation, provide a brief overview (less than 100 words) of the language you used, its origins, and its cultural significance, in Latin characters only.'
    ),
    Part.text(prompt)
  ]);
});