import 'dart:async';

import 'package:chiwi/js/audio_contexts/audio_context.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';

class Recorder {
  static const SILENCE_THRESHOLD = 15;
  static const SUBSCRIPTION_DURATION = 250;

  final _recorder = FlutterSoundRecorder(logLevel: .warning);
  final List<Uint8List> _chunks = List.empty(growable: true);
  int sampleRate = 48000;

  StreamController<Uint8List>? _streamController;
  StreamSubscription<Uint8List>? _dataSubscription;
  StreamSubscription<RecordingDisposition>? _progressSubscription;
  Completer<Uint8List>? _completer;

  void recordEvent(Uint8List data) {
    _chunks.add(data);
  }

  double _prevDecibels = 0;
  DateTime? _silenceTime = null;
  bool _soundDetected = false;

  void onProgressEvent(RecordingDisposition event) {
    final curTime = DateTime.now();
    // Wait until something is heard
    if (!_soundDetected) {
      if (event.decibels! > SILENCE_THRESHOLD) {
        if (_prevDecibels <= SILENCE_THRESHOLD) {
          _soundDetected = true;
        }
      }
      _prevDecibels = event.decibels!;
      return;
    }

    // Start listening
    if (event.decibels! > SILENCE_THRESHOLD) {
      _prevDecibels = event.decibels!;
      return;
    }

    // Wait until X amount of time for decibels to stay zero
    if (_silenceTime == null) {
      if (_prevDecibels > SILENCE_THRESHOLD &&
          event.decibels! <= SILENCE_THRESHOLD) {
        _silenceTime = curTime;
      }
    } else {
      if (curTime.difference(_silenceTime!).inMilliseconds >= 1000) {
        if (event.decibels! <= SILENCE_THRESHOLD) {
          stopRecording();
          return;
        }
        _silenceTime = null;
      }
    }
    _prevDecibels = event.decibels!;
  }

  Future<Uint8List> startRecording() async {
    _completer = Completer();

    _streamController = StreamController();
    sampleRate = AudioContext().sampleRate;

    _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(
      const Duration(milliseconds: SUBSCRIPTION_DURATION),
    );
    _recorder.startRecorder(
      codec: .pcm16,
      // TODO: Create a utility to get AudioContexts using js interop and get its sampleRate and put it here. then x2 on pcmToWaveBuffer() call
      sampleRate: 48000,
      toStream: _streamController!.sink,
    );
    _dataSubscription = _streamController!.stream.listen(recordEvent);
    _progressSubscription = _recorder.onProgress!.listen(onProgressEvent);

    return _completer!.future;
  }

  Future<void> stopRecording() async {
    await _dataSubscription!.cancel();
    await _progressSubscription!.cancel();
    _streamController!.close();
    _recorder.closeRecorder();
    final bytes = Uint8List.fromList(_chunks.expand((chunk) => chunk).toList());
    _resetVars();
    final converted = await FlutterSoundHelper().pcmToWaveBuffer(
      inputBuffer: bytes,
      sampleRate: sampleRate*2,
    );
    _completer!.complete(converted);
  }

  void _resetVars() {
    _prevDecibels = 0;
    _silenceTime;
    _soundDetected = false;
    _chunks.clear();
  }
}
