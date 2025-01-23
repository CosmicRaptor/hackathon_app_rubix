import 'package:flutter_tts/flutter_tts.dart';

class TTSservice {
  final String text;
  bool isSpeaking = false;
  late final FlutterTts flutterTts;
  TTSservice(this.text){
    flutterTts = FlutterTts();
  }

  Future<void> speak() async{
    await flutterTts.speak(text);
    isSpeaking = true;
  }

  Future<void> stop() async{
    await flutterTts.stop();
    isSpeaking = false;
  }
}