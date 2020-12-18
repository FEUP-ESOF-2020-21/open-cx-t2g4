import 'package:com_4_all/transcriber/TranscriberSpeechToText.dart';
import 'package:com_4_all/synthesizer/SynthesizerTextToSpeech.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:com_4_all/main.dart';
import 'package:com_4_all/Globals.dart';
import 'package:flutter/material.dart';
import 'package:com_4_all/SpeakerPage.dart';
import 'package:com_4_all/AttendeePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  group('Transcriber', ()
  {
    test('test', () {
      /*
      final transcriber = new TranscriberSpeechToText();

      transcriber.initialize(
          onBegin: beginListener,
          onResult: resultListener,
          onSoundLevel: soundLevelListener,
          onEnd: endListener,
          onError: errorListener);

      transcriber.initSpeech();
      transcriber.startListening();
      transcriber.isListening;
      */
    });
  });

  group('Synthesizer', ()
  {
    test('play', () {
      final synthesizer = new SynthesizerTextToSpeech((){});
      expect(synthesizer.isPlayingBool, false);
      synthesizer.startSynthesizer('Hello');
      expect(synthesizer.isPlayingBool, true);
    });

    test('set up language', () async {
      const channel = MethodChannel('flutter_tts');
      channel.setMockMethodCallHandler((MethodCall call) async {
        if (call.method == 'getLanguages')
          return ['pt-PT', 'pt-BR', 'en-US'];
        else if (call.method == 'isLanguageAvailable')
          return ['pt-PT', 'pt-BR', 'en-US'].contains('${call.arguments}');
        else if(call.method == 'setLanguage')
          return null;
        throw MissingPluginException();
      });

      final synthesizer = new SynthesizerTextToSpeech((){});
      await synthesizer.setupLanguages();
      expect(synthesizer.language, 'pt-PT');
      expect(synthesizer.languages, ['en-US', 'pt-BR', 'pt-PT']);

      synthesizer.setLanguage('en-US');
      expect(synthesizer.language, 'en-US');
    });

  });

  /*
  testWidgets('Speaker', (WidgetTester tester) async {
    //final app = new App();
    await tester.pumpWidget(MaterialApp(home: SpeakerPage()));
    await tester.pumpAndSettle();
    print(find.byKey(Key('attendeeBtn')));
    //await tester.tap(find.byKey(Key('attendeeBtn')));
    await tester.pumpAndSettle();
    //expect(settings, true);
  });
*/
}
