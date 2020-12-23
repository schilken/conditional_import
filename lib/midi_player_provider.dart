import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'midi_player_stub.dart'
    if (dart.library.io) 'midi_player_native.dart'
    if (dart.library.js) 'midi_player_web.dart';

abstract class MidiPlayer {
  Future<void> init();

  void play(int midi);
}

final midiProvider = Provider<MidiPlayer>((ref) {
  Logger('midiProvider');
  return getMidiPlayer();
});
