import 'package:com_4_all/transcriber/TranscriberResult.dart';
import 'package:com_4_all/transcriber/TranscriberSpeechToText.dart';
import 'package:com_4_all/synthesizer/SynthesizerTextToSpeech.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Transcriber', ()
  {
    const channel = MethodChannel('plugin.csdcorp.com/speech_to_text');
    channel.setMockMethodCallHandler((MethodCall call) async {
      if (call.method == 'initialize')
        return true;
      else if(call.method == 'stop')
        return true;
      else if(call.method == 'listen')
        return true;
      throw MissingPluginException();
    });

    test('Listen', () async{
      final transcriber = new TranscriberSpeechToText();
      transcriber.initialize(
          onBegin: (){},
          onResult: (TranscriberResult t){},
          onSoundLevel: (double d){},
          onEnd: (){},
          onError: (SpeechRecognitionError e){});
      expect(transcriber.isListening, false);
      await transcriber.initSpeech();
      transcriber.startListening();
      expect(transcriber.isListening, true);
      transcriber.stopListening();
      expect(transcriber.isListening, false);
    });
  });

  group('Synthesizer', ()
  {
    const channel = MethodChannel('flutter_tts');
    channel.setMockMethodCallHandler((MethodCall call) async {
      if (call.method == 'getLanguages')
        return ['pt-PT', 'pt-BR', 'en-US'];
      else if (call.method == 'isLanguageAvailable')
        return ['pt-PT', 'pt-BR', 'en-US'].contains('${call.arguments}');
      else if(call.method == 'setLanguage')
        return null;
      else if(call.method == 'setVolume')
        return null;
      else if(call.method == 'setSpeechRate')
        return null;
      else if(call.method == 'setPitch')
        return null;
      else if(call.method == 'speak')
        return null;
      throw MissingPluginException();
    });

    test('play', () {
      final synthesizer = new SynthesizerTextToSpeech((){});
      expect(synthesizer.isPlayingBool, false);
      synthesizer.startSynthesizer('Hello');
      expect(synthesizer.isPlayingBool, true);
    });

    test('set up language', () async {
      final synthesizer = new SynthesizerTextToSpeech((){});
      await synthesizer.setupLanguages();
      expect(synthesizer.language, 'pt-PT');
      expect(synthesizer.languages, ['en-US', 'pt-BR', 'pt-PT']);
      synthesizer.setLanguage('en-US');
      expect(synthesizer.language, 'en-US');
    });
  });
}
