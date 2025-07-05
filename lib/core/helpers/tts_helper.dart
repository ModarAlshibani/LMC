import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSHelper {
  FlutterTts? _flutterTts;
  bool _isSpeaking = false;
  bool _ttsAvailable = false;
  
  // Callbacks
  VoidCallback? _onSpeakingStart;
  VoidCallback? _onSpeakingComplete;
  Function(String)? _onError;

  // Getters
  bool get isSpeaking => _isSpeaking;
  bool get ttsAvailable => _ttsAvailable;

  // Initialize TTS
  Future<void> initialize({
    String language = "en-US",
    double speechRate = 0.5,
    double volume = 1.0,
    double pitch = 1.0,
    VoidCallback? onSpeakingStart,
    VoidCallback? onSpeakingComplete,
    Function(String)? onError,
  }) async {
    _onSpeakingStart = onSpeakingStart;
    _onSpeakingComplete = onSpeakingComplete;
    _onError = onError;

    try {
      _flutterTts = FlutterTts();

      // Configure TTS settings
      await _flutterTts!.setLanguage(language);
      await _flutterTts!.setSpeechRate(speechRate);
      await _flutterTts!.setVolume(volume);
      await _flutterTts!.setPitch(pitch);

      // Set up event handlers
      _flutterTts!.setStartHandler(() {
        _isSpeaking = true;
        _onSpeakingStart?.call();
      });

      _flutterTts!.setCompletionHandler(() {
        _isSpeaking = false;
        _onSpeakingComplete?.call();
      });

      _flutterTts!.setErrorHandler((msg) {
        _isSpeaking = false;
        _onError?.call(msg);
        print("TTS Error: $msg");
      });

      _ttsAvailable = true;
    } catch (e) {
      print("TTS initialization failed: $e");
      _ttsAvailable = false;
    }
  }

  // Speak text
  Future<void> speak(String text) async {
    if (!_ttsAvailable || _flutterTts == null) {
      _onError?.call("TTS not available");
      return;
    }

    try {
      if (_isSpeaking) {
        await _flutterTts!.stop();
      } else {
        await _flutterTts!.speak(text);
      }
    } catch (e) {
      print("TTS speak error: $e");
      _onError?.call("Failed to speak text");
    }
  }

  // Stop speaking
  Future<void> stop() async {
    if (_flutterTts != null) {
      try {
        await _flutterTts!.stop();
        _isSpeaking = false;
      } catch (e) {
        print("TTS stop error: $e");
      }
    }
  }

  // Set language
  Future<void> setLanguage(String language) async {
    if (_flutterTts != null) {
      try {
        await _flutterTts!.setLanguage(language);
      } catch (e) {
        print("TTS setLanguage error: $e");
      }
    }
  }

  // Set speech rate
  Future<void> setSpeechRate(double rate) async {
    if (_flutterTts != null) {
      try {
        await _flutterTts!.setSpeechRate(rate);
      } catch (e) {
        print("TTS setSpeechRate error: $e");
      }
    }
  }

  // Set volume
  Future<void> setVolume(double volume) async {
    if (_flutterTts != null) {
      try {
        await _flutterTts!.setVolume(volume);
      } catch (e) {
        print("TTS setVolume error: $e");
      }
    }
  }

  // Set pitch
  Future<void> setPitch(double pitch) async {
    if (_flutterTts != null) {
      try {
        await _flutterTts!.setPitch(pitch);
      } catch (e) {
        print("TTS setPitch error: $e");
      }
    }
  }

  // Get available languages
  Future<List<String>> getLanguages() async {
    if (_flutterTts != null) {
      try {
        final languages = await _flutterTts!.getLanguages;
        return List<String>.from(languages);
      } catch (e) {
        print("TTS getLanguages error: $e");
        return [];
      }
    }
    return [];
  }

  // Show TTS unavailable snackbar
  static void showTTSUnavailableSnackbar(BuildContext context, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Text-to-speech is not available on this device"),
        backgroundColor: backgroundColor ?? Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Dispose resources
  void dispose() {
    try {
      _flutterTts?.stop();
      _flutterTts = null;
    } catch (e) {
      print("TTS dispose error: $e");
    }
  }
}