import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechController extends GetxController {
  final SpeechToText _speechToText = SpeechToText();
  bool isListening = false;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
  }

  Future<String> startListening() async {
    String recognizedText = '';

    if (!isListening) {
      isListening = true;
      update();

      await _speechToText.listen(
        pauseFor: const Duration(seconds: 5),
        onResult: (result) {
          recognizedText = result.recognizedWords;
        },
      );

      await Future.delayed(const Duration(seconds: 5));
      await stopListening();
    }

    return recognizedText;
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    isListening = false;
    update();
  }
}
