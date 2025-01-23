import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:riverpod/riverpod.dart';

final promptProvider = StateProvider<String>((ref) => '');
final promptLanguageProvider = StateProvider<String>((ref) => 'Old English');

// StreamProvider to watch the stream based on the current prompt
final geminiPromptStreamProvider = StreamProvider<Candidates?>((ref) {
  final prompt = ref.watch(promptProvider); // Get the current prompt
  final promtLang = ref.watch(promptLanguageProvider); // Get the current prompt language

  final geminiService = Gemini.instance; // Replace with actual service
  return geminiService.promptStream(parts: [Part.text('Convert the following text to ${promtLang != 'Random' ? promtLang : 'any ancient language'} of your choice. After the translation, provide a brief overview(less than 100 words) of the language you used, and its origins. Do not send anything else.'), Part.text(prompt)]); // Pass the prompt to the stream
});