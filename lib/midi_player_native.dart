import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:logging/logging.dart';
import 'midi_player_provider.dart';

MidiPlayer getMidiPlayer() => MidiPlayerNative();

class MidiPlayerNative extends MidiPlayer {
  final logger = Logger('MidiPlayerNative');
  final _flutterMidi = FlutterMidi();

  String _soundFontName = 'assets/Nylon Guitar.sf2';

  Future<void> init() async {
    logger.fine('MidiPlayerNative.init');
    await load(_soundFontName);
  }

  Future<void> load(String asset) async {
    logger.fine("Loading File... $asset");
    _flutterMidi.unmute();
    ByteData _bytes = await rootBundle.load(asset);
    _flutterMidi.prepare(sf2: _bytes, name: asset.replaceAll("assets/", ""));
  }

  void play(int midi) {
    _flutterMidi.playMidiNote(midi: midi);
  }
}
