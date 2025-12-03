@JS()
library audio_context_interop;

import 'dart:js_interop';

@JS()
@staticInterop
class AudioContext {
  external factory AudioContext();
  
}

extension AudioContextJS on AudioContext {
  external int get sampleRate;
}

// @JS("AudioContext")
// external AudioContext createAudioContext();

// extension type AudioContext(JSObject it){
//   external int get sampleRate;
// }
