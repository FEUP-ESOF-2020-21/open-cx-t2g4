import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'Transcriber.dart';

class TranscriberSpeechToText extends Transcriber{
  /// Variables
  SpeechToText speech = SpeechToText();
  SpeechStatusListener onBegin;
  SpeechResultListener onResult;
  SpeechSoundLevelChange onSoundLevel;
  SpeechStatusListener onEnd;
  SpeechErrorListener onError;
  String locale;
  bool isListening = false;
  bool stoppedListening = false;

  /// Straight-forward getters and setters
  Future<List<LocaleName>> getLocales() { return speech.locales(); }
  Future<LocaleName> getSystemLocale() { return speech.systemLocale(); }
  void setLocale(String locale){ this.locale = locale; }
  String getLocale(){ return this.locale; }

  /// Constructor
  TranscriberSpeechToText({
    SpeechStatusListener onBegin,
    SpeechResultListener onResult,
    SpeechSoundLevelChange onSoundLevel,
    SpeechStatusListener onEnd,
    SpeechErrorListener onError
  }){
    this.onBegin = onBegin;
    this.onResult = onResult;
    this.onSoundLevel = onSoundLevel;
    this.onEnd = onEnd;
    this.onError = onError;
  }

  Future<bool> initSpeech() async {
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener
    );
    return hasSpeech;
  }

  void startListening(){
    speech.stop();
    isListening = true;
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(minutes: 1),
      localeId: locale,
      onSoundLevelChange: onSoundLevel,
      cancelOnError: true,
      partialResults: true
    );
  }

  void stopListening(){
    _log("stopListening");
    isListening = false;
    stoppedListening = true;
    speech.stop();
  }

  void cancelListening(){
    _log("cancelListening");
    speech.cancel();
  }

  bool gotTimeout = false;
  void errorListener(SpeechRecognitionError error) async {
    _log("errorListener: error: $error");
    if(error.errorMsg == "error_speech_timeout") {
      gotTimeout = true;
      return;
    }
    if(error.errorMsg == "error_no_match"){
      await Future.delayed(Duration(milliseconds: 50));
      startListening();
      return;
    }
    onError(error);
  }


  void resultListener(SpeechRecognitionResult result) async {
    _log("resultListener: $result");
    if(result.finalResult) {
      await Future.delayed(Duration(milliseconds: 50));
      startListening();
    }
    onResult(result);
  }

  void statusListener(String status) async {
    _log("statusListener: status: $status");
    if(gotTimeout && status == "notListening"){
      gotTimeout = false;
      await Future.delayed(Duration(milliseconds: 50));
      startListening();
      return;
    }
    if(isListening      && status == "listening") onBegin(status);
    if(stoppedListening && status == "notListening") onEnd(status);
  }

  void _log(String message){
    print("TranscriberSpeechToText (${DateTime.now().toString()}) | $message");
  }
}
