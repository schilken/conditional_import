import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:tonic/tonic.dart' as tonic;
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
    ByteData bytes = await rootBundle.load(asset);
    _flutterMidi.prepare(sf2: bytes, name: asset.replaceAll("assets/", ""));
  }

  void play(int midi) {
    logger.fine('play midi $midi');
    _flutterMidi.playMidiNote(midi: midi);
  }

  void playNote(String note) {
    logger.fine('playNote $note');
    final midi = tonic.name2midi(note);
    play(midi);
  }
}
