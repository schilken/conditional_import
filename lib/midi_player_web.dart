import 'midi_player_provider.dart';
import 'package:tonic/tonic.dart' as tonic;
import 'dart:js' as js;
import 'package:logging/logging.dart';

MidiPlayer getMidiPlayer() => MidiPlayerWeb();

class MidiPlayerWeb extends MidiPlayer {
  final logger = Logger('MidiPlayerWeb');
  Future<void> init() async {
    logger.fine('MidiPlayerWeb.init');
  }

  void play(int midi) {
    logger.fine('play midi $midi');
    String _note = tonic.Pitch.fromMidiNumber(midi).toString();
    _note = _note.replaceAll('♭', 'b').replaceAll('♯', '#');
    // print('Midi -> $midi/$_note');
    js.context.callMethod("playNote", ["$_note", "8n"]);
    // html.window.document.getElementById('midiPlay$midi').click();
  }
}
