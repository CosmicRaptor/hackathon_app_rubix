import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/services/tts_service.dart';
import 'package:hackathon_app_rubix/widgets/custom_scaffold.dart';
import 'package:hackathon_app_rubix/widgets/drawer.dart';

import '../services/translate_service.dart';

class OldLanguageTranslateScreen extends ConsumerStatefulWidget {
  OldLanguageTranslateScreen({super.key});

  @override
  ConsumerState<OldLanguageTranslateScreen> createState() => _OldLanguageTranslateScreenState();
}

class _OldLanguageTranslateScreenState extends ConsumerState<OldLanguageTranslateScreen> {
  final TextEditingController _textController = TextEditingController();
  bool toShowTranslation = false;
  String textOutput = '';
  String dropdownValue = 'Old English';
  TTSservice t1 = TTSservice('');
  bool isSpeaking = false;

  void initialiseTts(){
    t1 = TTSservice(textOutput);
  }

  bool toggleSpeaking(){
    isSpeaking = !isSpeaking;
    return isSpeaking;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Old Language Translate'),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Learn ancient languages', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              //dropdowns to select source and destination language
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Source: ', style: TextStyle(fontSize: 18),),
                      DropdownButton<String>(
                        value: 'English',
                        onChanged: (String? newValue) {},
                        items: <String>['English', 'Arabic', 'Hindi', 'Spanish']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 18),),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  //arrow to point towards destination dropdown
                  Icon(Icons.arrow_forward),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Destination: ', style: TextStyle(fontSize: 18),),
                      DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue ?? 'Old English';
                            ref.read(promptLanguageProvider.notifier).state = newValue ?? 'Old English';
                          });
                        },
                        items: <String>['Old English', 'Old greek', 'Sanskrit', 'Latin', 'Random']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 18),),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //600 word limit text area for input
              SizedBox(
                height: 300,
                child: TextField(
                  controller: _textController,
                  maxLines: 20,
                  maxLength: 600,
                  decoration: InputDecoration(
                    hintText: 'Enter text here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //translate button
              ElevatedButton(
                onPressed: () {
                  if(_textController.text.isNotEmpty){
                    setState(() {
                      ref.read(promptProvider.notifier).state = _textController.text;
                      toShowTranslation = true;
                    });
                  }
                },
                child: Text('Translate'),
              ),
              const SizedBox(height: 20),
              //translated text
              if(toShowTranslation)
              Card(
                color: Colors.brown.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Translated Text', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          IconButton(onPressed: (){
                            // initialiseTts();
                            if(t1.isSpeaking){
                              t1.stop();
                            }
                            else {
                              t1.speak();
                            }
                          }, icon: t1.isSpeaking ? Icon(Icons.stop) : Icon(Icons.volume_up), color: Colors.blue,),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ref.watch(geminiPromptStreamProvider).when(
                        data: (Candidates? candidates) {
                          // String text = '';
                          if(candidates != null){
                            textOutput += ' ${candidates.output} ';
                            initialiseTts();
                            return Text(textOutput);
                          }
                          return const Text('No translation available');
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) => Text('Error: $error'),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
