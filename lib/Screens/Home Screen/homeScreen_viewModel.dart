import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel{

  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

void initSpeech() async {
    speechEnabled = await speechToText.initialize();
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    lastWords = "";
    notifyListeners();
  }

  void stopListening() async {
    await speechToText.stop();
    notifyListeners();
  }

void onSpeechResult(SpeechRecognitionResult result) {
    
      lastWords = result.recognizedWords;
      notifyListeners();
  
  }

//Text To Speech:---------------------------------
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakText(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(0.3);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);      // Adjust pitch (1.0 is normal)
      await flutterTts.speak(text);  // Speak the provided text
      notifyListeners() ;        
    }

  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop(); 
  }

bool isActionsVisible = false;

  void onTextCopied() {
    isActionsVisible = true; // Enable the icons if necessary
    notifyListeners();
  }

  void resetActionsVisibility() {
    isActionsVisible = false; // Disable the icons
    notifyListeners();
  }

void clearTextField(){
  lastWords = "";
  notifyListeners();
}
}


